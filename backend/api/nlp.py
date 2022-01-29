from transformers import AutoModelForQuestionAnswering, AutoTokenizer, pipeline
from .data import context

model_name = "deepset/roberta-base-squad2-covid"
model_pipeline = pipeline('question-answering', model=model_name, tokenizer=model_name)
model = AutoModelForQuestionAnswering.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)

def answer(question):
    q_input = {
        'question':question,
        'context': context
    }

    y = model_pipeline(q_input)

    return y['answer']