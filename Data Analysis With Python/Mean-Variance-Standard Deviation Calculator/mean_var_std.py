import numpy as np

def calculate(list):
    if len(list) < 9:
        raise ValueError("List must contain nine numbers.")
    
    output = {}

    flat = np.array(list)
    matr = np.reshape(flat, (3,3))

    # axis1 axis2 flattened
    output['mean'] = [matr.mean(axis=0).tolist(), matr.mean(axis=1).tolist(), flat.mean(axis=0).item()]
    output['variance'] = [matr.var(axis=0).tolist(), matr.var(axis=1).tolist(), flat.var(axis=0).item()]
    output['standard deviation'] = [matr.std(axis=0).tolist(), matr.std(axis=1).tolist(), flat.std(axis=0).item()]
    output['max'] = [matr.max(axis=0).tolist(), matr.max(axis=1).tolist(), flat.max(axis=0).item()]
    output['min'] = [matr.min(axis=0).tolist(), matr.min(axis=1).tolist(), flat.min(axis=0).item()]
    output['sum'] = [matr.sum(axis=0).tolist(), matr.sum(axis=1).tolist(), flat.sum(axis=0).item()]

    return output

