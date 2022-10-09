# 논리회로 설계

**학번 : 2016111586 손채영**

# **Term project report**


## 주제

- **VHDL 로 커피 자판기 설계**

## **목차**

1. **[기능 및 조건](https://github.com/scy0626/vending_machine/blob/master/README.md#1-%EA%B8%B0%EB%8A%A5-%EB%B0%8F-%EC%A1%B0%EA%B1%B4:~:text=%EC%84%B8%EB%B6%80%20%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%A8%20code-,1.%20%EA%B8%B0%EB%8A%A5%20%EB%B0%8F%20%EC%A1%B0%EA%B1%B4,-%E2%91%A0%2050%EC%9B%90%2C%20100)**
2. **[설계 결과](https://github.com/scy0626/vending_machine/blob/master/README.md#1-%EA%B8%B0%EB%8A%A5-%EB%B0%8F-%EC%A1%B0%EA%B1%B4:~:text=%EB%8F%88%EC%9D%84%20%EC%9E%90%EB%8F%99%20%EB%B0%98%ED%99%98-,2.%20%EC%84%A4%EA%B3%84%20%EA%B2%B0%EA%B3%BC,-Synthesize%2DXST%EC%99%80)**
3. **[Port 변수설정](https://github.com/scy0626/vending_machine/blob/master/README.md#1-%EA%B8%B0%EB%8A%A5-%EB%B0%8F-%EC%A1%B0%EA%B1%B4:~:text=process.**-,3.%20port%20%EB%B3%80%EC%88%98%20%EC%84%A4%EC%A0%95,-Input0)**
4. **[Simulation 결과](https://github.com/scy0626/vending_machine/blob/master/README.md#1-%EA%B8%B0%EB%8A%A5-%EB%B0%8F-%EC%A1%B0%EA%B1%B4:~:text=in_coffee-,4.%20Simulation%20%EA%B2%B0%EA%B3%BC,-%EB%B0%98%ED%99%98%EB%B2%84%ED%8A%BC%EA%B3%BC%20reset%EB%B2%84%ED%8A%BC
)**
5. **[세부 프로그램 code](https://github.com/scy0626/vending_machine/blob/master/README.md#1-%EA%B8%B0%EB%8A%A5-%EB%B0%8F-%EC%A1%B0%EA%B1%B4:~:text=%EC%9B%90%3D250%EC%9B%90)-,5.%20%EC%84%B8%EB%B6%80%20%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%A8%20code,-1)%20entity)**

---

### 1. **기능 및 조건**

① 50원, 100원, 500원 투입 가능.

② 자판기의 커피가격은 200원

③ 반환 버튼

④ reset 버튼

⑤ 커피버튼

⑥ 750원 까지만 투입가능하고 그 후 자동반환

⑦ (추가) 일정시간동안 입력이 없으면 남은 돈을 자동 반환

### 2. **설계 결과**

**Synthesize-XST**와 **Implement Design**을 할 때 Error 가 뜨지 않았고 tb 파일을 만들어 시뮬레이션을 한 결과 성공적으로 값이 출력되고 이상이 없음을 확인하였다.

 ![image00002](https://user-images.githubusercontent.com/31886913/194742379-dec4f1b4-47d6-4e33-9155-48616b10d785.png)

단, Synthesize할 때 경고발생

out_50won 의 2,3번째 단위가 항상 0인 상수를 출력하기 때문에 최적화 단계에서 FF/Latch를 잘라낸다는 경고이므로 시스템을 실행하는데 크게 영향을 끼치지 않는다.

```vhdl
**WARNING:Xst:1896** **- Due to other FF/Latch trimming, FF/Latch <out_50won_2> has a constant value of 0 in block <test_vendingmachine_mod>. This FF/Latch will be trimmed during the optimization process.**
```

### 3. **port 변수 설정**

| Input |  | Output |  |
| --- | --- | --- | --- |
| clk | CLOCK | out_50won | 50원 반환 |
| reset | 초기화버튼 | out_100won | 100원 반환 |
| refund | 반환버튼 | out_500won | 500원 반환 |
| in_50won | 50원 투입 | out_coffee | 커피 출력 |
| in_100won | 100원 투입 | out_error | 잔액 부족으로 인한 error |
| in_500won | 500원 투입 |  |  |
| in_coffee |  |  |  |

### 4. **Simulation 결과**

- **반환버튼과 reset버튼 동작 확인**
    
![image00003](https://user-images.githubusercontent.com/31886913/194742380-8976502f-4478-4c28-af87-6e4f2afd118e.png)
    
   



50원 투입 → 100원 투입 → 500원 투입 → 반환버튼 → **650원 반환** → reset 버튼 → **출력값 초기화** → 50원 투입 → 50원 투입 → 100원 투입 → 반환버튼 → **200원 반환**

- **750원 이상 투입 후 자동반환과 일정시간 입력이 없을 때 자동반환 확인**
    
  
![image00004](https://user-images.githubusercontent.com/31886913/194742381-52b4cfea-88ee-4f21-9b07-396563261b2b.png)
    

500원 투입 → 500원 투입 → **1000원 반환** → 500원 투입 → 100원 투입 → 100원 투입 → 100원 투입 → **800원 반환** → 100원 투입 → 20clk 동안 입력 없이 대기 → **100원 반환**

- **커피버튼 동작 확인**
    

![image00005](https://user-images.githubusercontent.com/31886913/194742383-8fe41b5e-2cfc-474a-b94f-2ae92fd269a8.png)
    

50원 투입 → 100원 투입 → 커피버튼 → **잔액 부족 error** → 500원 투입 → 커피버튼 → **커피 출력** → 커피버튼 → **커피출력** → 반환버튼 → **250원 반환 (650원-200원-200원=250원)**

### 5. **세부 프로그램 code**

**1) entity**

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_vending_mod is
	port(clk, reset, refund: in std_logic;
			in_50won, in_100won, in_500won: in std_logic;
			in_coffee: in std_logic;
			out_50won, out_100won, out_500won : out std_logic_vector(2 downto 0):= "000";
			out_coffee, out_error: out std_logic :='0');

end test_vending_mod;
```

- input, output 각각의 port 선언 (각 port의 설명은 ‘3. port 변수 설정’ 참조)
- 동전이 투입되면 **in_50won, in_100won, in_500won <= ‘1’ ;**
- 버튼이 눌리면 **in_coffee, refund, reset <= ‘1’ ;**
- 동전이 반환되면 동전개수 만큼 **out_50won, out_100won, out_500won <= “XXX” ;**
- 커피가 출력되면 **out_coffee <= ‘1’ ;**
- 잔액이 부족하면 **out_error <= ‘1’ ;**
- out_50won, out_100won, out_500won 은 1 이상의 값을 표현해주기 위해 vector로 정의하였다.
- output 값의 경우 0 으로 미리 초기화 시켜주었다.

**2) architecture (state 정의)**

```vhdl
architecture Behavioral of test_vending_mod is
	--0~750state(total 16 state)
	type state_type is(won0, won50, won100, won150, won200, won250, won300, won350, won400, won450, won500, won550, won600, won650, won700, won750);
	signal state : state_type;
```

- 50원, 100원, 500원을 투입했을 때 0원~750원 까지 발생 가능한 모든 state를 고려한다.
- 0원, 50원, 100원, 150원, 200원, 250원, 300원, 350원, 400원, 450원, 500원, 550원, 600원, 650원, 700원, 750원 각각의 state를 **‘wonX**’ 로 정의 하였다.
- **state_type** 에 총 16개의 경우의 수를 생성 하였고 **state**를 변수로 지정하여 생성 하였다.

**3) process 선언**

```vhdl
begin
	process(clk, reset, refund, in_50won, in_100won, in_500won, in_coffee)
		variable nul : integer := 0;
		constant nul_max : integer := 20;
```

- FSM을 이용하여 순차문으로 작성하였기 때문에 process를 사용하였다.
- 입력으로 clk, reset, refund, in_50won, in_100won, in_500won, in_coffee를 사용한다.
- ‘1. 기능 및 조건 ⑦’의 추가기능을 구현하기 위해서 nul과 nul_max를 정의해 주었다.

**4) null 상태**

- null 상태의 동작 : 일정시간동안 입력이 없으면 남은 돈을 자동 반환 한다. 한번의 clk 상승이 있을 때 마다 nul값이 1 씩 증가하고 state의 변화가 있으면 nul값이 0으로 초기화 된다. 만약 state의 변화가 없어 nul값이 nul_max까지 상승한다면 현재 남아있는 잔액을 모두 반환하게 된다.
- nul_max 값은 20으로 설정하였기 때문에 20번의 상승edge 동안 state에 아무 변화가 없다면 현재 state 잔액이 모두 반환된다. (ex. clk 의 주기가 20ns 라면 400ns 동안 state변환이 없을 경우)
- 각 state 마다 **nul = nul_max** 라면 현재 state의 잔액을 반환하는 코드를 추가하였다.

**5) reset 기능**

```vhdl
begin
		if (reset = '1') then 
			state <= won0;
			out_50won <= "000";
			out_100won <= "000";
			out_500won <= "000";
```

- 현재 state와 무관하게 **reset = ‘1’** 일 때 모든 값들을 초기화 한다.
- state가 0원이 되고 반환 되는 돈들도 모두 “000”으로 초기화 된다.

**6) clk 사용 정의**

```vhdl
elsif (clk'event and clk = '1') then
			out_coffee <= '0';
			out_error <= '0';
```

- clk 의 상승edge에서 state가 변하게 된다.
- **out_coffee <= ‘0’ , out_error <= ‘0’** 은 한번 커피버튼이 눌려 커피나 에러가 출력되었을 때 계속해서 1이 되는 것을 막기 위해서 다음 상승edge에서 0으로 초기화 해준다.

**7) 각 state 별 동작**

- case 문을 이용하여 각각의 state에 따른 출력 값을 결정한다.
- 0원~750원 의 Total 16개의 state
- if 문을 이용하여 각각의 입력에 따른 state의 변화를 수정한다.

---
<details>
<summary>State = won0 (0원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 0원이므로 0원을 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 모자란 state이므로 out_error 에 1을 넣어 error를 출력한다. 
	
 state의 변화가 없으므로 nul += 1 , won0 state를 유지한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won0)에서 50원을 더한 won50 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won0)에서 100원을 더한 won100 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won0)에서 500원을 더한 won500 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won0 state를 유지한다.
	
</div>
</details>

<details>
<summary>State = won50 (50원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 50원이므로 50원 1개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 모자란 상태이므로 out_error 에 1을 넣어 error를 출력한다. 
	
 state의 변화가 없으므로 nul += 1 , won50 상태를 유지한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won50)에서 50원을 더한 won100 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won50)에서 100원을 더한 won150 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won50)에서 500원을 더한 won550 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won50 state를 유지한다.
	
</div>
</details>

<details>
<summary>State = won100 (100원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 100원이므로 100원 1개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 모자란 상태이므로 out_error 에 1을 넣어 error를 출력한다. 
	
 state의 변화가 없으므로 nul += 1 , won100 상태를 유지한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won100)에서 50원을 더한 won150 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won100)에서 100원을 더한 won200 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won100)에서 500원을 더한 won600 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won100 state를 유지한다.
	
</div>
</details>

<details>
<summary>State = won150 (150원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 150원이므로 50원 1개, 100원 1개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 모자란 상태이므로 out_error 에 1을 넣어 error를 출력한다. 
	
 state의 변화가 없으므로 nul += 1 , won150 상태를 유지한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won150)에서 50원을 더한 won200 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won150)에서 100원을 더한 won250 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won150)에서 500원을 더한 won650 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won150 state를 유지한다.
	
</div>
</details>

<details>
<summary>State = won200 (200원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 200원이므로 100원 2개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won0 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won200)에서 50원을 더한 won250 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won200)에서 100원을 더한 won300 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won200)에서 500원을 더한 won700 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won200 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won250 (250원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 250원이므로 50원 1개, 100원 2개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won50 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won250)에서 50원을 더한 won300 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won250)에서 100원을 더한 won350 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won250)에서 500원을 더한 won750 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won250 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won50 (50원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 300원이므로 100원 3개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won100 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won300)에서 50원을 더한 won350 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won300)에서 100원을 더한 won400 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 800원이 되므로 100원 3개, 500원 1개를 반환하고 won0 state 로   변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won300 state를 유지한다.
	
</div>
</details>

<details>
<summary>State = won350 (350원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 350원이므로 50원 1개, 100원 3개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won150 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won350)에서 50원을 더한 won400 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won350)에서 100원을 더한 won450 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 850원이 되므로 50원 1개, 100원 3개, 500원 1개를 반환하고 won0 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won350 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won400 (400원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 400원이므로 100원 4개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won200 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won400)에서 50원을 더한 won450 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won400)에서 100원을 더한 won500 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 900원이 되므로 100원 4개, 500원 1개를 반환하고 won0 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won400 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won450 (450원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 450원이므로 50원 1개, 100원 4개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won250 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won450)에서 50원을 더한 won500 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won450)에서 100원을 더한 won550 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 950원이 되므로 50원 1개, 100원 4개, 500원 1개를 반환하고 won0 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won450 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won500 (500원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 500원이므로 500원 1개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won300 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won500)에서 50원을 더한 won550 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won500)에서 100원을 더한 won600 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 1000원이 되므로 500원 2개를 반환하고 won0 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won500 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won550 (550원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 550원이므로 50원 1개, 500원 1개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won350 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won550)에서 50원을 더한 won600 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won550)에서 100원을 더한 won650 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 1050원이 되므로 50원 1개, 500원 2개를 반환하고 won0 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won550 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won600 (600원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 600원이므로 100원 1개, 500원 1개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won400 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won600)에서 50원을 더한 won650 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won600)에서 100원을 더한 won700 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 1100원이 되므로 100원 1개, 500원 2개를 반환하고 won0 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won600 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won650 (650원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 650원이므로 50원 1개, 100원 1개, 500원 1개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won450 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won650)에서 50원을 더한 won700 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won650)에서 100원을 더한 won750 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 1150원이 되므로 50원 1개, 100원 1개, 500원 2개를 반환하고 won0 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won650 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won700 (700원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 700원이므로 100원 2개, 500원 1개를 반환하고 won0 state 로 변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won500 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 state를 현재 state(won700)에서 50원을 더한 won750 state 로 변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 100원을 더하면 최댓값 750원이 넘는 800원이 되므로 100원 3개, 500원 1개를 반환하고 won0 state 로 변경한다.
	
 state를 현재 state(won650)에서 100원을 더한 won750 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 1200원이 되므로 100원 2개, 500원 2개를 반환하고 won0 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won700 state를 유지한다.
	
</div>
</details>
    
<details>
<summary>State = won750 (750원)</summary>
<div markdown="1"> 
	
if 반환버튼이 눌러지는 경우 or nul 이 20을 도달할 경우
	
 반환버튼이 눌러지는 경우 750원이므로 50원 1개, 100원 2개, 500원 1개를 반환하고 won0 state 로   변경한다.
	
 nul 이 max에 도달한 경우라면 nul을 0 초기화 시킨 후 반환버튼과 같은 동작을 한다. 
	
elsif 커피버튼이 눌러지는 경우
	
 커피를 사기위한 돈이 충분한 상태이므로 out_coffee 에 1을 넣어 커피를 출력한다. 
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 커피 값(200원)을 뺀  won550 state 로 변경한다.
	
elsif 50원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 50원을 더하면 최댓값 750원이 넘는 800원이 되므로 100원 3개, 500원 1개를 반환하고 won0 state 로   변경한다.
	
elsif 100원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 100원을 더하면 최댓값 750원이 넘는 850원이 되므로 50원 1개, 100원 3개, 500원 1개를 반환하고 won0 state 로 변경한다.
	
 state를 현재 state(won650)에서 100원을 더한 won750 state 로 변경한다.
	
elsif 500원이 투입된 경우
	
 state의 변화가 있으므로 nul = 0 으로 초기화 한다.
	
 500원을 더하면 최댓값 750원이 넘는 1250원이 되므로 50원 1개, 100원 2개, 500원 2개를 반환하고     won0 state 로 변경한다.
	
else 입력이 없을 경우
	
 state의 변화가 없으므로 nul += 1 , won750 state를 유지한다.
	
</div>
</details>
