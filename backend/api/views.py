from django.shortcuts import render
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import HttpResponse
from .models import Qna
from .serializers import QnaSerializer
from .nlp import answer

# Create your views here.

from rest_framework import viewsets
from .serializers import QnaSerializer
from .models import Qna


class QnaViewSet(viewsets.ModelViewSet):
    queryset = Qna.objects.all()
    serializer_class = QnaSerializer


'''
run model in backend 
post the question from app
forward prop model with posted question
return the answer
'''

class ChatBot(APIView):

    def get(self,request):
        que = Qna.objects.all()
        serializer = QnaSerializer(que,many=True)
        return Response(serializer.data)

    
    def post(self,request):
        serializer = QnaSerializer(data=request.data)
        
        if serializer.is_valid():
            serializer.save()
            print("question = "+request.data['qna'])
            out = answer(request.data['qna'])
            print("answer = "+out)
            return HttpResponse(out)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

