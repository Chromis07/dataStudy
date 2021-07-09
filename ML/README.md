*My notion* : https://www.notion.so/f39513ddb1d64e2fba8a5c8b1b37ba3b

# 지도학습
지도학습에는 분류, 회귀가 존재.

## k-NN

가장 간단한 머신러닝 알고리즘

- 훈련 데이터 셋을 그냥 저장하는 것이 모델을 만드는 과정의 전부
- 가장 가까운 훈련 데이터 포인트 하나를 최근접 이웃으로 찾아 예측에 사용

```python
import matplotlib.pyplot as plt
import mglearn

plt.figure(dpi= 100)
plt.rc('font', family = 'NAnumBarunGothic')

mglearn.plots.plot_knn_classification(n_neighbors=1) # 제일 근접한 1개 이웃 선택
```

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/681e43e9-dc20-4256-b5ac-ff42d71eafca/_(8).png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/681e43e9-dc20-4256-b5ac-ff42d71eafca/_(8).png)

```python
plt.figure(dpi= 100)
plt.rc('font', family = 'NAnumBarunGothic')

mglearn.plots.plot_knn_classification(n_neighbors=3) # 제일 근접한 3개 이웃 선택
```

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6693c312-1682-4cfb-acf4-01ff88b5297c/_(9).png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6693c312-1682-4cfb-acf4-01ff88b5297c/_(9).png)

→ KNN 중 이웃이 더 많은 클래스가 레이블로 지정

→ 다수의 클래스가 레이블

### kNN 알고리즘 구현 - 분류

- 클래스 0과 클래스 1로 지정된 영역으로 나뉘는 결정경계(decision boundary) 확인 가능
- 이웃의 수를 늘릴 수록 결정경계는 더 부드러워짐
- 부드러운 경계는 더 단순한 모델을 의미

→ 이웃을 적게 사용하면 모델 복잡도 ↑

→ 이웃을 많이 사용하면 모델 복잡도 ↓

### kNN 회귀

- k=1의 경우 가장 가까운 이웃의 타겟값
- k ≥ 2의 경우 회귀분석 → 여러개의 최근접 이웃 간의 평균이 예측 값

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f86917ff-355c-4e7c-b6cd-9d58e611dee0/_(11).png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f86917ff-355c-4e7c-b6cd-9d58e611dee0/_(11).png)

### kNN 의 장단점

중요한 매개변수 : 데이터 포인트 사이의 거리를 재는 방법, 이웃의 수

장점

- 이해하기 매우 쉬움
- 많이 조정하지 않아도 자주 좋은 성을 발휘하기 때문에 더 복잡한 알고리즘을 적용해보기 전에 시도해볼 수 있는 좋은 시작점 (baseline)

단점

- train set이 너무 크면 예측이 느려짐
- k-NN 알고리즘을 사용할 땐 데이터를 전처리하는 과정이 중요
- (수백 개 이상의) 많은 특성을 가진 데이터 셋에는 잘 동작하지 않음
- 특성 값 대부분이 0인 (희소한) dataset에는 잘 작동하지 않음

예측이 느리고 많은 특성을 처리하는 능력이 부족해 현업에서는 잘 쓰지 않음

이런 단점이 없는 알고리즘 → 선형 모델

## 선형 모델 (Linear model)

- 100년 전에 개발되어, 현재도 널리 쓰임
- 입력 특성에 대한 선형 함수를 만들어 예측을 수행
- 간단하지만 성능이 더 훌륭함
- 때문에 kNN보다 선형 모델을 basic line으로 두는 경우가 많음
- 평균제곱오차MSE를 최소화하는 파라미터 w(weight)와 b(입실론)을 찾는 것이 목표
- 1차원 데이터셋는 모델이 매우 단순하여 overfitting될 위험이 없음
- 고차원 데이터셋에서는 선형 모델의 성능이 너무 높아져서 overfitting될 위험이 있음

해보니...

- test set 에서는 R2값이 매우 낮음

→ overfitting → 확실한 신호이므로 → 릿지 회귀

### 릿지 회귀 (Ridge Regression)

선형 회귀처럼 다 받아줄 생각 없어!!

- 모든 특성이 출력에 주는 영향을 최소한으로 만듬(기울기를 작게 만듬) → 이런 제약을 규제(Regularization)

규제(Regularization)

- 규제와 overfitting 되지 않도록 모델을 강제로 제한한다는 의미
- 릿지 회귀에 사용하는 규제 방식을 L2 규제라고 함
- 수학적으로 릿지는 계수의 L2 놈 norm의 제곱을 페널티로 적용

### 라쏘 회귀 (Lasso Regression)

L2 norm을 사용하는 릿지를 더 사용하긴 함..

- 릿지에 비해, L1 규제를 사용함 → 0에 가까워지는 것이 아닌, 정말 0이 됨

alpha값을 너무 낮추면 규제가 없어져 Linear Regression이랑 다를바 없어짐

