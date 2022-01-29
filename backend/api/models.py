from django.db import models

# Create your models here.
class Qna(models.Model):
    qna = models.CharField(max_length=200)
    
    def __str__(self):
        return self.qna