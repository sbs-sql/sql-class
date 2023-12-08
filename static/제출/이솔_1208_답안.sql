-- 사원이름, 직책 조회
select ename, job from emp

-- 1. 사원번호, 사수번호, 사원이름, 급여조회
select empno, mgr , ename , sal from emp

-- where 원하는 데이터 추출(조건식)
-- 직책이 MANAGER이고 이름이 CLARK인 직책, 사원이름 조회
select job, ename from emp where job = 'MANAGER'
and ename = 'CLARK'


-- 1981-09-08 이후 입사한 사원 이름, 입사날짜 조회
select ename, hiredate  from emp where hiredate >= '1981-09-08'

-- q1)부서번호가 10번이고 급여가 2000이상인 사원 이름, 입사날짜, 직책조회
select ename, hiredate, job from emp 
where deptno = '10' and sal >= '2000'

-- 사원 급여 조회
select sal+100 as sal from emp
select sal*2 as sal from emp

-- 기존 급여에 3% 보너스 인상
select (sal*0.03)+sal from emp -- sal * 1.03
-- sql에서 연산식이 가능하지만 실무에선 사용하지 않는다.
-- why? 모든 연산은 java, python과 같은 프로그램에서 사용한다.

-- 급여가 1250 ~ 2000달러를 받는 사원이름, 급여, 직책 조회
select ename, sal, job from emp 
where sal >= 1250 and sal <=2000
-- 범위를 표현하는 다른 방법
select ename, sal, job from emp 
where sal between 1250 and 2000
-- between A and B : A~B까지

-- 급여가 1000 이하, 2000이상 받는 사원이름, 급여, 직책 조회
select ename, sal, job from emp 
where sal <= 1000 or sal >=2000

-- 정렬 order by
-- desc는 내림차순, asc는 오름차순
-- order by 기본값은 오름차순!
select ename, hiredate from emp 
order by hiredate 

select ename, sal from emp 
order by sal desc

select job, ename, sal from emp 
order by 3 desc # sal이 몇번째인지 
--  SQL 실행순서
-- 1. FROM 2. WHERE 3. SELECT 4. ORDER BY

-- 직책이 MANAGER인 사원의 직책, 급여, 이름 조회(급여를 내림차순으로 정렬함)
select job, sal, ename from emp 
where job = 'MANAGER'
order by 2 desc

-- NULL은 데이터가 없음을 의미
-- comm이 null인 사원이름, 직책, 보너스 조회
select ename, job, comm from emp 
where comm is null

-- comm이 null이 아닌사원이름, 직책, 보너스 조회
select ename, job, comm from emp 
where comm is not null

-- null에 임시로 데이터 채워주기
-- ifnull(컬럼이름, 임시데이터)
-- ifnull() <-- 내장함수
select ifnull(comm, 700) from emp

-- *****집계함수
-- sum(총합), avg(평균), count(모든 행의 수), max(최댓값), min(최솟값)

-- 사원 급여 총합 구하기
select sum(sal) '전체 급여' from emp

-- 직업이 MANAGER 사원 급여 총합 조회
select sum(sal) 'MANAGER' from emp 
where job = 'MANAGER'

-- 직업이 manager이고 입사날짜가 1981-04-02인  급여 총합 조회
select sum(sal) '전체 급여' from emp 
where job = 'MANAGER' and hiredate = '1981-04-02'

-- 부서번호가 20번인 사원 급여 평균
select avg(sal) '급여'from emp where deptno = 20

-- 직업이 MANAGER인 사원 중 sal이 가장 높은 급여만 조회
select max(sal) from emp where job = 'MANAGER'

-- *****날짜 함수
-- 사원 입사일 조회
select hiredate from emp

-- 사원 입사일 중 월만 조회
-- '%m' 숫자 월 의미, '%M' 영어로 월이 나옴
select date_format(hiredate, '%m') from emp 

-- 일자만 나오게
select date_format(hiredate, '%d') from emp 
-- 월, 일만 출력
select date_format(hiredate, '%m-%d') from emp 

-- 6월달에 입사한 사원의 이름, 직책, 입사날짜 급여 출력
select ename, job, hiredate, sal from emp 
where date_format(hiredate, '%m') ='06' 

-- 1. 사원번호, 사원이름, 부서번호, 사수번호 조회
select empno, ename, deptno, mgr from emp
-- 2. 사원이름, 급여, 입사날짜 조회
select ename, sal, hiredate from emp
-- 3. 급여가 1500 이상 받는 사원번호, 이름, 급여, 직책 조회
select empno, ename, sal, job from emp 
where sal >= 1500
-- 4. 급여가 1500 이상이고 직책이 SALESMAN인 사원 번호, 이름, 급여, 직책 조회
select empno, ename, sal, job from emp 
where sal >= 1500 and job = 'SALESMAN'
-- 5. 급여가 1500 ~ 2850 사이의 범위에 속하지 않는 모든 사원의 이름, 급여 조회
select ename, sal from emp 
where sal < 1500 or sal > 2850
-- 6. 1981년 2월 20일 ~ 1981년 5월 1일에 입사한 사원의 이름, 입사일 조회
select ename, hiredate from emp 
where hiredate between '1981-02-20' and '1981-05-01'
-- 7. 부서가 10, 30에 속하는 사원 중 급여가 1500을 넘는 사원의 이름 및 급여 조회
select ename, sal from emp 
where sal > 1500 and deptno = 10 or 30
-- 8. 1982년에 입사한 모든 사원의 이름과 입사일 조회
select ename, hiredate from emp 
where hiredate = 1982
-- 9. 직업이 manager 사람들의 급여 평균을 조회
select avg(sal) from emp where job = 'MANAGER'
-- 10. 입사날짜가 1987-06-28 이후 입사한 사원들의 급여 평균 조회.
select avg(sal) from emp where hiredate > '1987-06-28'
-- 11. 9월에 입사한 사원의 이름, 번호, 입사날짜 조회
select ename, empno, hiredate from emp 
where date_format(hiredate, '%m') = '09' 
-- 12. 직업이 SALESMAN 이고 입사날짜가 1981-02-22 이후에 들어온 사원들의 급여 총합, 급여평균 조회.
select sum(sal), avg(sal) from emp 
where job = 'SALESMAN' and hiredate > '1981-02-22'
-- 13. 직업이 MANAGER고 SALESMAN 사원들 이름, 직업, 급여 조회 단, 급여를 내림차순으로 정렬
select ename, job, sal from emp 
where job = 'MANAGER' or 'SALESMAN' 
order by sal desc
-- 14. 보너스를 받은 사원 이름, 보너스 조회 단, 0도 제외.
select ename, comm from emp 
where comm > 0
-- 15. 1983년 이후 입사한 사원의 급여 10%를 보너스로 주고, 사원의 이름, 보너스 금액, 급여, 입사날짜(년도만) 조회
select ename, (sal*0.1)+comm, date_format(hiredate, '%y') from emp
where hiredate > 1983

















