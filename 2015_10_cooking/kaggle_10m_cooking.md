
# 캐글뽀개기 10월 What's Cooking 발표자 이상열
## https://www.kaggle.com/c/whats-cooking/
![](https://kaggle2.blob.core.windows.net/competitions/kaggle/4526/logos/front_page.png)

- Use recipe ingredients to categorize the cuisine
- Picture yourself strolling through your local, open-air market... What do you see? What do you smell? What will you make for dinner tonight?
- If you're in Northern California, you'll be walking past the inevitable bushels of leafy greens, spiked with dark purple kale and the bright pinks and yellows of chard. Across the world in South Korea, mounds of bright red kimchi greet you, while the smell of the sea draws your attention to squids squirming nearby. India’s market is perhaps the most colorful, awash in the rich hues and aromas of dozens of spices: turmeric, star anise, poppy seeds, and garam masala as far as the eye can see.
- Some of our strongest geographic and cultural associations are tied to a region's local foods. This playground competitions asks you to predict the category of a dish's cuisine given a list of its ingredients. 

- 재료의 목록을 보고 요리의 범주(국가)를 예측하는 문제. 

- http://www.yummly.com/

<img src="yummly_c.jpg" alt="alt text" title="Title"/>

~~~~
json 형태 파일
{
 "id": 24717,
 "cuisine": "indian",
 "ingredients": [
     "tumeric",
     "vegetable stock",
     "tomatoes",
     "garam masala",
     "naan",
     "red lentils",
     "red chili peppers",
     "onions",
     "spinach",
     "sweet potatoes"
 ]
 },
~~~~

- train.json - the training set containing recipes id, type of cuisine, and list of ingredients
- test.json - the test set containing recipes id, and list of ingredients
- sample_submission.csv - a sample submission file in the correct format

- 평가방법 (Submissions are evaluated on the categorization accuracy (the percent of dishes that you correctly classify).
![](https://docs.wso2.com/download/attachments/47520050/Multiclass_Classification_Matrix_Definition.png?version=1&modificationDate=1441305075000&api=v2)
![](https://docs.wso2.com/download/attachments/47520050/Multi_Class_Classification.png?version=2&modificationDate=1441304458000&api=v2)


```R
install.packages(c('rzmq','repr','IRkernel','IRdisplay'), repos = 'http://irkernel.github.io/')
```

    
      바이너리 버전을 이용할 수 있습니다 (그리고 설치되어질 것입니다)
      그러나 소스 버전은 추후에 제공될 것입니다:
         binary source
    repr    0.3    0.4
    
    package 'rzmq' successfully unpacked and MD5 sums checked
    

    Warning message:
    : cannot remove prior installation of package 'rzmq'

    package 'repr' successfully unpacked and MD5 sums checked
    package 'IRkernel' successfully unpacked and MD5 sums checked
    package 'IRdisplay' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    


```R
IRkernel::installspec()
```


```R
install.packages("jsonlite", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("dplyr", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("ggplot2", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("tm", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("caret", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("rpart.plot", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("SnowballC", dependencies=T, repos='http://cran.rstudio.com/') 
```

    also installing the dependencies 'memoise', 'mime', 'bitops', 'Rcpp', 'crayon', 'praise', 'evaluate', 'formatR', 'highr', 'markdown', 'yaml', 'htmltools', 'caTools', 'R.methodsS3', 'R.oo', 'R.utils', 'R.cache', 'curl', 'plyr', 'testthat', 'knitr', 'rmarkdown', 'R.rsp'
    
    

    package 'memoise' successfully unpacked and MD5 sums checked
    package 'mime' successfully unpacked and MD5 sums checked
    package 'bitops' successfully unpacked and MD5 sums checked
    package 'Rcpp' successfully unpacked and MD5 sums checked
    package 'crayon' successfully unpacked and MD5 sums checked
    package 'praise' successfully unpacked and MD5 sums checked
    package 'evaluate' successfully unpacked and MD5 sums checked
    package 'formatR' successfully unpacked and MD5 sums checked
    package 'highr' successfully unpacked and MD5 sums checked
    package 'markdown' successfully unpacked and MD5 sums checked
    package 'yaml' successfully unpacked and MD5 sums checked
    package 'htmltools' successfully unpacked and MD5 sums checked
    package 'caTools' successfully unpacked and MD5 sums checked
    package 'R.methodsS3' successfully unpacked and MD5 sums checked
    package 'R.oo' successfully unpacked and MD5 sums checked
    package 'R.utils' successfully unpacked and MD5 sums checked
    package 'R.cache' successfully unpacked and MD5 sums checked
    package 'curl' successfully unpacked and MD5 sums checked
    package 'plyr' successfully unpacked and MD5 sums checked
    package 'testthat' successfully unpacked and MD5 sums checked
    package 'knitr' successfully unpacked and MD5 sums checked
    package 'rmarkdown' successfully unpacked and MD5 sums checked
    package 'R.rsp' successfully unpacked and MD5 sums checked
    package 'jsonlite' successfully unpacked and MD5 sums checked
    

    Warning message:
    : cannot remove prior installation of package 'jsonlite'

    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    

    also installing the dependencies 'colorspace', 'RColorBrewer', 'dichromat', 'munsell', 'labeling', 'chron', 'gtable', 'reshape2', 'scales', 'proto', 'assertthat', 'R6', 'magrittr', 'lazyeval', 'DBI', 'RSQLite', 'RMySQL', 'RPostgreSQL', 'data.table', 'microbenchmark', 'ggplot2', 'Lahman', 'nycflights13'
    
    

    package 'colorspace' successfully unpacked and MD5 sums checked
    package 'RColorBrewer' successfully unpacked and MD5 sums checked
    package 'dichromat' successfully unpacked and MD5 sums checked
    package 'munsell' successfully unpacked and MD5 sums checked
    package 'labeling' successfully unpacked and MD5 sums checked
    package 'chron' successfully unpacked and MD5 sums checked
    package 'gtable' successfully unpacked and MD5 sums checked
    package 'reshape2' successfully unpacked and MD5 sums checked
    package 'scales' successfully unpacked and MD5 sums checked
    package 'proto' successfully unpacked and MD5 sums checked
    package 'assertthat' successfully unpacked and MD5 sums checked
    package 'R6' successfully unpacked and MD5 sums checked
    package 'magrittr' successfully unpacked and MD5 sums checked
    package 'lazyeval' successfully unpacked and MD5 sums checked
    package 'DBI' successfully unpacked and MD5 sums checked
    package 'RSQLite' successfully unpacked and MD5 sums checked
    package 'RMySQL' successfully unpacked and MD5 sums checked
    package 'RPostgreSQL' successfully unpacked and MD5 sums checked
    package 'data.table' successfully unpacked and MD5 sums checked
    package 'microbenchmark' successfully unpacked and MD5 sums checked
    package 'ggplot2' successfully unpacked and MD5 sums checked
    package 'Lahman' successfully unpacked and MD5 sums checked
    package 'nycflights13' successfully unpacked and MD5 sums checked
    package 'dplyr' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    

    also installing the dependencies 'zoo', 'SparseM', 'MatrixModels', 'Formula', 'latticeExtra', 'acepack', 'gridExtra', 'sp', 'mvtnorm', 'TH.data', 'sandwich', 'quantreg', 'Hmisc', 'mapproj', 'maps', 'hexbin', 'maptools', 'multcomp'
    
    

    package 'zoo' successfully unpacked and MD5 sums checked
    package 'SparseM' successfully unpacked and MD5 sums checked
    package 'MatrixModels' successfully unpacked and MD5 sums checked
    package 'Formula' successfully unpacked and MD5 sums checked
    package 'latticeExtra' successfully unpacked and MD5 sums checked
    package 'acepack' successfully unpacked and MD5 sums checked
    package 'gridExtra' successfully unpacked and MD5 sums checked
    package 'sp' successfully unpacked and MD5 sums checked
    package 'mvtnorm' successfully unpacked and MD5 sums checked
    package 'TH.data' successfully unpacked and MD5 sums checked
    package 'sandwich' successfully unpacked and MD5 sums checked
    package 'quantreg' successfully unpacked and MD5 sums checked
    package 'Hmisc' successfully unpacked and MD5 sums checked
    package 'mapproj' successfully unpacked and MD5 sums checked
    package 'maps' successfully unpacked and MD5 sums checked
    package 'hexbin' successfully unpacked and MD5 sums checked
    package 'maptools' successfully unpacked and MD5 sums checked
    package 'multcomp' successfully unpacked and MD5 sums checked
    package 'ggplot2' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    

    Warning message:
    : dependencies 'Rcampdf', 'Rgraphviz', 'Rpoppler', 'tm.lexicon.GeneralInquirer' are not availablealso installing the dependencies 'NLP', 'slam', 'filehash', 'SnowballC', 'XML'
    
    

    package 'NLP' successfully unpacked and MD5 sums checked
    package 'slam' successfully unpacked and MD5 sums checked
    package 'filehash' successfully unpacked and MD5 sums checked
    package 'SnowballC' successfully unpacked and MD5 sums checked
    package 'XML' successfully unpacked and MD5 sums checked
    package 'tm' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    

    Warning message:
    : dependency 'rPython' is not availablealso installing the dependencies 'numDeriv', 'minqa', 'nloptr', 'profileModel', 'plotrix', 'lava', 'pbkrtest', 'iterators', 'lme4', 'brglm', 'gtools', 'plotmo', 'TeachingDemos', 'prodlim', 'combinat', 'modeltools', 'strucchange', 'coin', 'car', 'foreach', 'BradleyTerry2', 'e1071', 'earth', 'fastICA', 'gam', 'ipred', 'kernlab', 'klaR', 'ellipse', 'mda', 'mlbench', 'party', 'pls', 'pROC', 'proxy', 'randomForest', 'RANN', 'spls', 'subselect', 'pamr', 'superpc', 'Cubist'
    
    

    package 'numDeriv' successfully unpacked and MD5 sums checked
    package 'minqa' successfully unpacked and MD5 sums checked
    package 'nloptr' successfully unpacked and MD5 sums checked
    package 'profileModel' successfully unpacked and MD5 sums checked
    package 'plotrix' successfully unpacked and MD5 sums checked
    package 'lava' successfully unpacked and MD5 sums checked
    package 'pbkrtest' successfully unpacked and MD5 sums checked
    package 'iterators' successfully unpacked and MD5 sums checked
    package 'lme4' successfully unpacked and MD5 sums checked
    package 'brglm' successfully unpacked and MD5 sums checked
    package 'gtools' successfully unpacked and MD5 sums checked
    package 'plotmo' successfully unpacked and MD5 sums checked
    package 'TeachingDemos' successfully unpacked and MD5 sums checked
    package 'prodlim' successfully unpacked and MD5 sums checked
    package 'combinat' successfully unpacked and MD5 sums checked
    package 'modeltools' successfully unpacked and MD5 sums checked
    package 'strucchange' successfully unpacked and MD5 sums checked
    package 'coin' successfully unpacked and MD5 sums checked
    package 'car' successfully unpacked and MD5 sums checked
    package 'foreach' successfully unpacked and MD5 sums checked
    package 'BradleyTerry2' successfully unpacked and MD5 sums checked
    package 'e1071' successfully unpacked and MD5 sums checked
    package 'earth' successfully unpacked and MD5 sums checked
    package 'fastICA' successfully unpacked and MD5 sums checked
    package 'gam' successfully unpacked and MD5 sums checked
    package 'ipred' successfully unpacked and MD5 sums checked
    package 'kernlab' successfully unpacked and MD5 sums checked
    package 'klaR' successfully unpacked and MD5 sums checked
    package 'ellipse' successfully unpacked and MD5 sums checked
    package 'mda' successfully unpacked and MD5 sums checked
    package 'mlbench' successfully unpacked and MD5 sums checked
    package 'party' successfully unpacked and MD5 sums checked
    package 'pls' successfully unpacked and MD5 sums checked
    package 'pROC' successfully unpacked and MD5 sums checked
    package 'proxy' successfully unpacked and MD5 sums checked
    package 'randomForest' successfully unpacked and MD5 sums checked
    package 'RANN' successfully unpacked and MD5 sums checked
    package 'spls' successfully unpacked and MD5 sums checked
    package 'subselect' successfully unpacked and MD5 sums checked
    package 'pamr' successfully unpacked and MD5 sums checked
    package 'superpc' successfully unpacked and MD5 sums checked
    package 'Cubist' successfully unpacked and MD5 sums checked
    package 'caret' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    package 'rpart.plot' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    package 'SnowballC' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    


```R
library(jsonlite)
library(dplyr)
library(ggplot2)
library(tm) # For NLP; creating bag-of-words
library(caret)
library(rpart)
library(rpart.plot)
library(SnowballC)
```


    Error in library(jsonlite): there is no package called 'jsonlite'
    


    
    Attaching package: 'dplyr'
    
    The following objects are masked from 'package:stats':
    
        filter, lag
    
    The following objects are masked from 'package:base':
    
        intersect, setdiff, setequal, union
    
    Loading required package: NLP
    
    Attaching package: 'NLP'
    
    The following object is masked from 'package:ggplot2':
    
        annotate
    
    Loading required package: lattice
    


```R
load("json.Rdata")
```


```R
ls()
```




<ol class=list-inline>
	<li>"test"</li>
	<li>"train"</li>
</ol>





```R
head(train)
```




<table>
<thead><tr><th></th><th scope=col>id</th><th scope=col>cuisine</th><th scope=col>ingredients</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>10259</td><td>greek</td><td>romaine lettuce, black olives, grape tomatoes, garlic, pepper, purple onion, seasoning, garbanzo beans, feta cheese crumbles</td></tr>
	<tr><th scope=row>2</th><td>25693</td><td>southern_us</td><td>plain flour, ground pepper, salt, tomatoes, ground black pepper, thyme, eggs, green tomatoes, yellow corn meal, milk, vegetable oil</td></tr>
	<tr><th scope=row>3</th><td>20130</td><td>filipino</td><td>eggs, pepper, salt, mayonaise, cooking oil, green chilies, grilled chicken breasts, garlic powder, yellow onion, soy sauce, butter, chicken livers</td></tr>
	<tr><th scope=row>4</th><td>22213</td><td>indian</td><td>water, vegetable oil, wheat, salt</td></tr>
	<tr><th scope=row>5</th><td>13162</td><td>indian</td><td>black pepper, shallots, cornflour, cayenne pepper, onions, garlic paste, milk, butter, salt, lemon juice, water, chili powder, passata, oil, ground cumin, boneless chicken skinless thigh, garam masala, double cream, natural yogurt, bay leaf</td></tr>
	<tr><th scope=row>6</th><td>6602</td><td>jamaican</td><td>plain flour, sugar, butter, eggs, fresh ginger root, salt, ground cinnamon, milk, vanilla extract, ground ginger, powdered sugar, baking powder</td></tr>
</tbody>
</table>




~~~~
ID 요리 재료
1 10259 그리스어로 메인 양상추, 블랙 올리브, 포도, 토마토, 마늘, 고추, 보라색 양파, 조미료, garbanzo 콩, 죽은 태아의 치즈는 잘게
2 25693 southern_us 일반 밀가루, 후추, 소금, 토마토, 지상 후추, 타임, 계란, 녹색 토마토, 노란 옥수수 가루, 우유, 식물성 기름
3 20130 필리핀 계란, 후추, 소금, mayonaise, 기름, 녹색 고추, 구운 닭 가슴살, 마늘 분말, 노란 양파, 간장, 버터, 닭의 간 요리
4 22213 인도 물, 식물성 기름, 밀가루, 소금
5 13162 인도 후추, 골파, 옥수수 가루, 카이엔 고추, 양파, 마늘 페이스트, 우유, 버터, 소금, 레몬 주스, 물, 고추 가루, passata, 오일, 지상 커 민, 뼈없는 닭 껍질을 벗기는 허벅지, 가람 마살라, 더블 크림, 천연 요구르트, 베이 리프
6 6602 자메이카 일반 밀가루, 설탕, 버터, 계란, 신선한 생강 뿌리, 소금, 분말 계피, 우유, 바닐라 추출물, 지상 생강, 가루 설탕, 베이킹 파우더
~~~~


```R
head(test)
```




<table>
<thead><tr><th></th><th scope=col>id</th><th scope=col>ingredients</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>18009</td><td>baking powder, eggs, all-purpose flour, raisins, milk, white sugar</td></tr>
	<tr><th scope=row>2</th><td>28583</td><td>sugar, egg yolks, corn starch, cream of tartar, bananas, vanilla wafers, milk, vanilla extract, toasted pecans, egg whites, light rum</td></tr>
	<tr><th scope=row>3</th><td>41580</td><td>sausage links, fennel bulb, fronds, olive oil, cuban peppers, onions</td></tr>
	<tr><th scope=row>4</th><td>29752</td><td>meat cuts, file powder, smoked sausage, okra, shrimp, andouille sausage, water, paprika, hot sauce, garlic cloves, browning, lump crab meat, vegetable oil, all-purpose flour, freshly ground pepper, flat leaf parsley, boneless chicken skinless thigh, dried thyme, white rice, yellow onion, ham</td></tr>
	<tr><th scope=row>5</th><td>35687</td><td>ground black pepper, salt, sausage casings, leeks, parmigiano reggiano cheese, cornmeal, water, extra-virgin olive oil</td></tr>
	<tr><th scope=row>6</th><td>38527</td><td>baking powder, all-purpose flour, peach slices, corn starch, heavy cream, lemon juice, unsalted butter, salt, white sugar</td></tr>
</tbody>
</table>




~~~~
ID 성분
1 18009 베이킹 파우더, 계란, 다목적 밀가루, 건포도, 우유, 백설탕
2 28583 설탕, 달걀 노른자, 옥수수 전분, 치석, 바나나, 바닐라 웨이퍼, 우유, 바닐라 추출물, 구운 피칸, 달걀 흰자의 크림, 라이트 럼
3 41580 소시지 링크, 회향 전구, 잎, 올리브 오일, 쿠바 고추, 양파
4 29752 고기 인하, 파일 가루, 훈제 소시지, 오크라, 새우, andouille 소시지, 물, 파프리카, 핫 소스, 다진 마늘, 갈색, 덩어리 게 고기, 식물성 기름, 다목적 밀가루, 갓 지상 후추, 평면 잎 파슬리, 뼈없는 닭 껍질을 벗기는 허벅지, 말린 백리향, 흰 쌀, 노란 양파, 햄
5 35687 지상 후추, 소금, 소시지 케이싱, 부추, 파르 미자의 reggiano 치즈, 옥수수 가루, 물, 엑스트라 버진 올리브 오일
6 38527 베이킹 파우더, 다목적 밀가루, 복숭아 조각, 옥수수 전분, 무거운 크림, 레몬 주스, 무염 버터, 소금, 흰 설탕
~~~~

### 데이터 전처리 필요
- 트윗이나 다른 텍스트 데이터처럼 태그나 url이나 불필요한 자료가 없기 때문에 스페이스 기준으로 추출만 하면 됨.
- 모두 소문자이기 때문에 따로 전처리 할 필요는 없고... 불용어 제거할 필요도 없음 (명사 단어만 있기 때문에)
- 재료가 ,로 구분되어 있으니 이것만 제외해서 나눠주면 되고 문제는 단어를 몇개까지 매트릭스에 집어넣을것인가...


```R
sample_sub <- read.csv('sample_submission.csv')
```


```R
head(sample_sub)
```




<table>
<thead><tr><th></th><th scope=col>id</th><th scope=col>cuisine</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>35203</td><td>italian</td></tr>
	<tr><th scope=row>2</th><td>17600</td><td>italian</td></tr>
	<tr><th scope=row>3</th><td>35200</td><td>italian</td></tr>
	<tr><th scope=row>4</th><td>17602</td><td>italian</td></tr>
	<tr><th scope=row>5</th><td>17605</td><td>italian</td></tr>
	<tr><th scope=row>6</th><td>17604</td><td>italian</td></tr>
</tbody>
</table>





```R
ingredients <- Corpus(VectorSource(c(train$ingredients,test$ingredients)))
```


```R
ingredients
```




    <<VCorpus>>
    Metadata:  corpus specific: 0, document level (indexed): 0
    Content:  documents: 49718




```R
?Corpus #tm package Corpus~
```

    Warning message:
    In read.dcf(file.path(p, "DESCRIPTION"), c("Package", "Version")): 압축된 파일 'C:/Anaconda/R/library/jsonlite/DESCRIPTION'를 열 수 없습니다.  그 이유는 아마도 'No such file or directory'입니다Warning message:
    In read.dcf(file.path(p, "DESCRIPTION"), c("Package", "Version")): 압축된 파일 'C:/Anaconda/R/library/rzmq/DESCRIPTION'를 열 수 없습니다.  그 이유는 아마도 'No such file or directory'입니다Warning message:
    In find.package(if (is.null(package)) loadedNamespaces() else package, : there is no package called 'jsonlite'Warning message:
    In find.package(if (is.null(package)) loadedNamespaces() else package, : there is no package called 'rzmq'





<table width="100%" summary="page for Corpus {tm}"><tr><td>Corpus {tm}</td><td align="right">R Documentation</td></tr></table>

<h2>Corpora</h2>

<h3>Description</h3>

<p>Representing and computing on corpora.
</p>


<h3>Details</h3>

<p><EM>Corpora</EM> are collections of documents containing (natural language)
text. In packages which employ the infrastructure provided by package
<span class="pkg">tm</span>, such corpora are represented via the virtual S3 class
<code>Corpus</code>: such packages then provide S3 corpus classes extending the
virtual base class (such as <code>VCorpus</code> provided by package <span class="pkg">tm</span>
itself).
</p>
<p>All extension classes must provide accessors to extract subsets
(<code>[</code>), individual documents (<code>[[</code>), and metadata
(<code>meta</code>). The function <code>length</code> must return the number
of documents, and <code>as.list</code> must construct a list holding the
documents.
</p>
<p>A corpus can have two types of metadata (accessible via <code>meta</code>).
<EM>Corpus metadata</EM> contains corpus specific metadata in form of tag-value
pairs. <EM>Document level metadata</EM> contains document specific metadata but
is stored in the corpus as a data frame. Document level metadata is typically
used for semantic reasons (e.g., classifications of documents form an own
entity due to some high-level information like the range of possible values)
or for performance reasons (single access instead of extracting metadata of
each document).
</p>


<h3>See Also</h3>

<p><code>VCorpus</code>, and <code>PCorpus</code> for the corpora classes
provided by package <span class="pkg">tm</span>.
</p>
<p><code>DCorpus</code> for a distributed corpus class provided by
package <span class="pkg">tm.plugin.dc</span>.
</p>

<hr><div align="center">[Package <em>tm</em> version 0.6-2 ]</div>




```R
ingredients <- tm_map(ingredients, stemDocument)
```


```R
ingredients
```




    <<VCorpus>>
    Metadata:  corpus specific: 0, document level (indexed): 0
    Content:  documents: 49718




```R
ingredientsDTM <- DocumentTermMatrix(ingredients)
```


```R
?DocumentTermMatrix
```

    Warning message:
    In read.dcf(file.path(p, "DESCRIPTION"), c("Package", "Version")): 압축된 파일 'C:/Anaconda/R/library/jsonlite/DESCRIPTION'를 열 수 없습니다.  그 이유는 아마도 'No such file or directory'입니다Warning message:
    In read.dcf(file.path(p, "DESCRIPTION"), c("Package", "Version")): 압축된 파일 'C:/Anaconda/R/library/rzmq/DESCRIPTION'를 열 수 없습니다.  그 이유는 아마도 'No such file or directory'입니다Warning message:
    In find.package(if (is.null(package)) loadedNamespaces() else package, : there is no package called 'jsonlite'Warning message:
    In find.package(if (is.null(package)) loadedNamespaces() else package, : there is no package called 'rzmq'





<table width="100%" summary="page for TermDocumentMatrix {tm}"><tr><td>TermDocumentMatrix {tm}</td><td align="right">R Documentation</td></tr></table>

<h2>Term-Document Matrix</h2>

<h3>Description</h3>

<p>Constructs or coerces to a term-document matrix or a document-term matrix.
</p>


<h3>Usage</h3>

<pre>
TermDocumentMatrix(x, control = list())
DocumentTermMatrix(x, control = list())
as.TermDocumentMatrix(x, ...)
as.DocumentTermMatrix(x, ...)
</pre>


<h3>Arguments</h3>

<table summary="R argblock">
<tr valign="top"><td><code>x</code></td>
<td>
<p>a corpus for the constructors and either a term-document
matrix or a document-term matrix or a simple
triplet matrix (package <span class="pkg">slam</span>) or a term
frequency vector for the coercing functions.</p>
</td></tr>
<tr valign="top"><td><code>control</code></td>
<td>
<p>a named list of control options. There are local
options which are evaluated for each document and global options
which are evaluated once for the constructed matrix. Available local
options are documented in <code>termFreq</code> and are internally
delegated to a <code>termFreq</code> call. Available global options
are:
</p>

<dl>
<dt><code>bounds</code></dt><dd><p>A list with a tag <code>global</code> whose value
must be an integer vector of length 2. Terms that appear in less
documents than the lower bound <code>bounds$global[1]</code> or in
more documents than the upper bound <code>bounds$global[2]</code> are
discarded. Defaults to <code>list(global = c(1, Inf))</code> (i.e., every
term will be used).</p>
</dd>
<dt><code>weighting</code></dt><dd><p>A weighting function capable of handling a
<code>TermDocumentMatrix</code>. It defaults to <code>weightTf</code> for term
frequency weighting. Available weighting functions shipped with
the <span class="pkg">tm</span> package are <code>weightTf</code>,
<code>weightTfIdf</code>, <code>weightBin</code>, and
<code>weightSMART</code>.</p>
</dd>
</dl>
</td></tr>
<tr valign="top"><td><code>...</code></td>
<td>
<p>the additional argument <code>weighting</code> (typically a
<code>WeightFunction</code>) is allowed when coercing a
simple triplet matrix to a term-document or document-term matrix.</p>
</td></tr>
</table>


<h3>Value</h3>

<p>An object of class <code>TermDocumentMatrix</code> or class
<code>DocumentTermMatrix</code> (both inheriting from a
simple triplet matrix in package <span class="pkg">slam</span>)
containing a sparse term-document matrix or document-term matrix. The
attribute <code>Weighting</code> contains the weighting applied to the
matrix.
</p>


<h3>See Also</h3>

<p><code>termFreq</code> for available local control options.
</p>


<h3>Examples</h3>

<pre>
data("crude")
tdm &lt;- TermDocumentMatrix(crude,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE))
dtm &lt;- DocumentTermMatrix(crude,
                          control = list(weighting =
                                         function(x)
                                         weightTfIdf(x, normalize =
                                                     FALSE),
                                         stopwords = TRUE))
inspect(tdm[202:205, 1:5])
inspect(tdm[c("price", "texas"), c("127", "144", "191", "194")])
inspect(dtm[1:5, 273:276])
</pre>

<hr><div align="center">[Package <em>tm</em> version 0.6-2 ]</div>




```R
ingredientsDTM
```




    <<DocumentTermMatrix (documents: 49718, terms: 2886)>>
    Non-/sparse entries: 927832/142558316
    Sparsity           : 99%
    Maximal term length: 25
    Weighting          : term frequency (tf)



## Term frequency
- https://ko.wikipedia.org/wiki/TF-IDF
- TF(단어 빈도, term frequency)는 특정한 단어가 문서 내에 얼마나 자주 등장하는지를 나타내는 값으로, 이 값이 높을수록 문서에서 중요하다고 생각할 수 있다. 하지만 단어 자체가 문서군 내에서 자주 사용되는 경우, 이것은 그 단어가 흔하게 등장한다는 것을 의미한다. 이것을 DF(문서 빈도, document frequency)라고 하며, 이 값의 역수를 IDF(역문서 빈도, inverse document frequency)라고 한다. TF-IDF는 TF와 IDF를 곱한 값이다.


```R
sparse <- removeSparseTerms(ingredientsDTM, 0.99)
```


```R
sparse
```




    <<DocumentTermMatrix (documents: 49718, terms: 250)>>
    Non-/sparse entries: 808758/11620742
    Sparsity           : 93%
    Maximal term length: 13
    Weighting          : term frequency (tf)




```R
?removeSparseTerms
```

    Warning message:
    In read.dcf(file.path(p, "DESCRIPTION"), c("Package", "Version")): 압축된 파일 'C:/Anaconda/R/library/jsonlite/DESCRIPTION'를 열 수 없습니다.  그 이유는 아마도 'No such file or directory'입니다Warning message:
    In read.dcf(file.path(p, "DESCRIPTION"), c("Package", "Version")): 압축된 파일 'C:/Anaconda/R/library/rzmq/DESCRIPTION'를 열 수 없습니다.  그 이유는 아마도 'No such file or directory'입니다Warning message:
    In find.package(if (is.null(package)) loadedNamespaces() else package, : there is no package called 'jsonlite'Warning message:
    In find.package(if (is.null(package)) loadedNamespaces() else package, : there is no package called 'rzmq'





<table width="100%" summary="page for removeSparseTerms {tm}"><tr><td>removeSparseTerms {tm}</td><td align="right">R Documentation</td></tr></table>

<h2>Remove Sparse Terms from a Term-Document Matrix</h2>

<h3>Description</h3>

<p>Remove sparse terms from a document-term or term-document matrix.
</p>


<h3>Usage</h3>

<pre>
removeSparseTerms(x, sparse)
</pre>


<h3>Arguments</h3>

<table summary="R argblock">
<tr valign="top"><td><code>x</code></td>
<td>
<p>A <code>DocumentTermMatrix</code> or a
<code>TermDocumentMatrix</code>.</p>
</td></tr>
<tr valign="top"><td><code>sparse</code></td>
<td>
<p>A numeric for the maximal allowed sparsity in the range from
bigger zero to smaller one.</p>
</td></tr>
</table>


<h3>Value</h3>

<p>A term-document matrix where those terms from <code>x</code> are
removed which have at least a <code>sparse</code> percentage of empty (i.e.,
terms occurring 0 times in a document) elements. I.e., the resulting
matrix contains only terms with a sparse factor of less than
<code>sparse</code>.
</p>


<h3>Examples</h3>

<pre>
data("crude")
tdm &lt;- TermDocumentMatrix(crude)
removeSparseTerms(tdm, 0.2)
</pre>

<hr><div align="center">[Package <em>tm</em> version 0.6-2 ]</div>




```R
ingredientsDTM <- as.data.frame(as.matrix(sparse))
```


```R
head(ingredientsDTM)
```




<table>
<thead><tr><th></th><th scope=col>all-purpos</th><th scope=col>allspic</th><th scope=col>almond</th><th scope=col>and</th><th scope=col>appl</th><th scope=col>avocado</th><th scope=col>babi</th><th scope=col>bacon</th><th scope=col>bake</th><th scope=col>balsam</th><th scope=col>basil</th><th scope=col>bay</th><th scope=col>bean</th><th scope=col>beansprout</th><th scope=col>beef</th><th scope=col>bell</th><th scope=col>black</th><th scope=col>boil</th><th scope=col>boneless</th><th scope=col>bread</th><th scope=col>breast</th><th scope=col>broccoli</th><th scope=col>broth</th><th scope=col>brown</th><th scope=col>butter</th><th scope=col>buttermilk</th><th scope=col>cabbag</th><th scope=col>canola</th><th scope=col>caper</th><th scope=col>cardamom</th><th scope=col>carrot</th><th scope=col>cayenn</th><th scope=col>celeri</th><th scope=col>cheddar</th><th scope=col>chees</th><th scope=col>cherri</th><th scope=col>chicken</th><th scope=col>chickpea</th><th scope=col>chile</th><th scope=col>chili</th><th scope=col>chines</th><th scope=col>chip</th><th scope=col>chipotl</th><th scope=col>chive</th><th scope=col>chocol</th><th scope=col>chop</th><th scope=col>cider</th><th scope=col>cilantro</th><th scope=col>cinnamon</th><th scope=col>clove</th><th scope=col>coars</th><th scope=col>coconut</th><th scope=col>cold</th><th scope=col>condens</th><th scope=col>confection</th><th scope=col>cook</th><th scope=col>coriand</th><th scope=col>corn</th><th scope=col>cornmeal</th><th scope=col>crack</th><th scope=col>cream</th><th scope=col>crumb</th><th scope=col>crumbl</th><th scope=col>crush</th><th scope=col>cucumb</th><th scope=col>cumin</th><th scope=col>curri</th><th scope=col>dark</th><th scope=col>dice</th><th scope=col>dijon</th><th scope=col>dill</th><th scope=col>dough</th><th scope=col>dress</th><th scope=col>dri</th><th scope=col>egg</th><th scope=col>eggplant</th><th scope=col>enchilada</th><th scope=col>extra-virgin</th><th scope=col>extract</th><th scope=col>fat</th><th scope=col>fennel</th><th scope=col>feta</th><th scope=col>fillet</th><th scope=col>fine</th><th scope=col>firm</th><th scope=col>fish</th><th scope=col>flake</th><th scope=col>flat</th><th scope=col>flour</th><th scope=col>free</th><th scope=col>fresh</th><th scope=col>frozen</th><th scope=col>garam</th><th scope=col>garlic</th><th scope=col>ginger</th><th scope=col>golden</th><th scope=col>granul</th><th scope=col>grate</th><th scope=col>greek</th><th scope=col>green</th><th scope=col>ground</th><th scope=col>halv</th><th scope=col>ham</th><th scope=col>heavi</th><th scope=col>hoisin</th><th scope=col>honey</th><th scope=col>hot</th><th scope=col>ice</th><th scope=col>italian</th><th scope=col>jack</th><th scope=col>jalapeno</th><th scope=col>juic</th><th scope=col>kalamata</th><th scope=col>kernel</th><th scope=col>ketchup</th><th scope=col>kosher</th><th scope=col>lamb</th><th scope=col>larg</th><th scope=col>leaf</th><th scope=col>lean</th><th scope=col>leav</th><th scope=col>leek</th><th scope=col>lemon</th><th scope=col>less</th><th scope=col>lettuc</th><th scope=col>light</th><th scope=col>lime</th><th scope=col>low</th><th scope=col>low-fat</th><th scope=col>masala</th><th scope=col>mayonais</th><th scope=col>meat</th><th scope=col>medium</th><th scope=col>mexican</th><th scope=col>milk</th><th scope=col>minc</th><th scope=col>mint</th><th scope=col>mirin</th><th scope=col>mix</th><th scope=col>monterey</th><th scope=col>mozzarella</th><th scope=col>mushroom</th><th scope=col>mustard</th><th scope=col>noodl</th><th scope=col>nutmeg</th><th scope=col>oil</th><th scope=col>oliv</th><th scope=col>onion</th><th scope=col>orang</th><th scope=col>oregano</th><th scope=col>oyster</th><th scope=col>paprika</th><th scope=col>parmesan</th><th scope=col>parsley</th><th scope=col>past</th><th scope=col>pasta</th><th scope=col>pea</th><th scope=col>peanut</th><th scope=col>pecan</th><th scope=col>peel</th><th scope=col>pepper</th><th scope=col>peppercorn</th><th scope=col>plain</th><th scope=col>plum</th><th scope=col>pork</th><th scope=col>potato</th><th scope=col>powder</th><th scope=col>purpl</th><th scope=col>raisin</th><th scope=col>red</th><th scope=col>reduc</th><th scope=col>rib</th><th scope=col>rice</th><th scope=col>ricotta</th><th scope=col>roast</th><th scope=col>root</th><th scope=col>rosemari</th><th scope=col>saffron</th><th scope=col>sage</th><th scope=col>salsa</th><th scope=col>salt</th><th scope=col>sauc</th><th scope=col>sausag</th><th scope=col>scallion</th><th scope=col>sea</th><th scope=col>season</th><th scope=col>seed</th><th scope=col>serrano</th><th scope=col>sesam</th><th scope=col>shallot</th><th scope=col>sharp</th><th scope=col>shell</th><th scope=col>sherri</th><th scope=col>shiitak</th><th scope=col>shoulder</th><th scope=col>shred</th><th scope=col>shrimp</th><th scope=col>skinless</th><th scope=col>slice</th><th scope=col>smoke</th><th scope=col>soda</th><th scope=col>sodium</th><th scope=col>soup</th><th scope=col>sour</th><th scope=col>soy</th><th scope=col>spaghetti</th><th scope=col>spinach</th><th scope=col>spray</th><th scope=col>sprig</th><th scope=col>spring</th><th scope=col>squash</th><th scope=col>starch</th><th scope=col>steak</th><th scope=col>stick</th><th scope=col>stock</th><th scope=col>sugar</th><th scope=col>sweet</th><th scope=col>sweeten</th><th scope=col>syrup</th><th scope=col>taco</th><th scope=col>thai</th><th scope=col>thigh</th><th scope=col>thyme</th><th scope=col>toast</th><th scope=col>tofu</th><th scope=col>tomato</th><th scope=col>tortilla</th><th scope=col>tumer</th><th scope=col>turkey</th><th scope=col>turmer</th><th scope=col>unsalt</th><th scope=col>unsweeten</th><th scope=col>vanilla</th><th scope=col>veget</th><th scope=col>vinegar</th><th scope=col>warm</th><th scope=col>water</th><th scope=col>wedg</th><th scope=col>wheat</th><th scope=col>whip</th><th scope=col>white</th><th scope=col>whole</th><th scope=col>wine</th><th scope=col>worcestershir</th><th scope=col>yeast</th><th scope=col>yellow</th><th scope=col>yogurt</th><th scope=col>yolk</th><th scope=col>zest</th><th scope=col>zucchini</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>
	<tr><th scope=row>2</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>
	<tr><th scope=row>3</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>
	<tr><th scope=row>4</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>
	<tr><th scope=row>5</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>
	<tr><th scope=row>6</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>
</tbody>
</table>





```R
ingredientsDTM_train <- ingredientsDTM[1:39774,]
ingredientsDTM_test <- ingredientsDTM[39775:49718,]
```


```R
dim(ingredientsDTM_train)
dim(ingredientsDTM_test)
```




<ol class=list-inline>
	<li>39774</li>
	<li>250</li>
</ol>







<ol class=list-inline>
	<li>9944</li>
	<li>250</li>
</ol>





```R
ingredientsDTM_train$cuisine <- as.factor(train$cuisine)
ingredientsDTM_test$cuisine <- NA
```


```R
head(ingredientsDTM_train)
```




<table>
<thead><tr><th></th><th scope=col>all-purpos</th><th scope=col>allspic</th><th scope=col>almond</th><th scope=col>and</th><th scope=col>appl</th><th scope=col>avocado</th><th scope=col>babi</th><th scope=col>bacon</th><th scope=col>bake</th><th scope=col>balsam</th><th scope=col>basil</th><th scope=col>bay</th><th scope=col>bean</th><th scope=col>beansprout</th><th scope=col>beef</th><th scope=col>bell</th><th scope=col>black</th><th scope=col>boil</th><th scope=col>boneless</th><th scope=col>bread</th><th scope=col>breast</th><th scope=col>broccoli</th><th scope=col>broth</th><th scope=col>brown</th><th scope=col>butter</th><th scope=col>buttermilk</th><th scope=col>cabbag</th><th scope=col>canola</th><th scope=col>caper</th><th scope=col>cardamom</th><th scope=col>carrot</th><th scope=col>cayenn</th><th scope=col>celeri</th><th scope=col>cheddar</th><th scope=col>chees</th><th scope=col>cherri</th><th scope=col>chicken</th><th scope=col>chickpea</th><th scope=col>chile</th><th scope=col>chili</th><th scope=col>chines</th><th scope=col>chip</th><th scope=col>chipotl</th><th scope=col>chive</th><th scope=col>chocol</th><th scope=col>chop</th><th scope=col>cider</th><th scope=col>cilantro</th><th scope=col>cinnamon</th><th scope=col>clove</th><th scope=col>coars</th><th scope=col>coconut</th><th scope=col>cold</th><th scope=col>condens</th><th scope=col>confection</th><th scope=col>cook</th><th scope=col>coriand</th><th scope=col>corn</th><th scope=col>cornmeal</th><th scope=col>crack</th><th scope=col>cream</th><th scope=col>crumb</th><th scope=col>crumbl</th><th scope=col>crush</th><th scope=col>cucumb</th><th scope=col>cumin</th><th scope=col>curri</th><th scope=col>dark</th><th scope=col>dice</th><th scope=col>dijon</th><th scope=col>dill</th><th scope=col>dough</th><th scope=col>dress</th><th scope=col>dri</th><th scope=col>egg</th><th scope=col>eggplant</th><th scope=col>enchilada</th><th scope=col>extra-virgin</th><th scope=col>extract</th><th scope=col>fat</th><th scope=col>fennel</th><th scope=col>feta</th><th scope=col>fillet</th><th scope=col>fine</th><th scope=col>firm</th><th scope=col>fish</th><th scope=col>flake</th><th scope=col>flat</th><th scope=col>flour</th><th scope=col>free</th><th scope=col>fresh</th><th scope=col>frozen</th><th scope=col>garam</th><th scope=col>garlic</th><th scope=col>ginger</th><th scope=col>golden</th><th scope=col>granul</th><th scope=col>grate</th><th scope=col>greek</th><th scope=col>green</th><th scope=col>ground</th><th scope=col>halv</th><th scope=col>ham</th><th scope=col>heavi</th><th scope=col>hoisin</th><th scope=col>honey</th><th scope=col>hot</th><th scope=col>ice</th><th scope=col>italian</th><th scope=col>jack</th><th scope=col>jalapeno</th><th scope=col>juic</th><th scope=col>kalamata</th><th scope=col>kernel</th><th scope=col>ketchup</th><th scope=col>kosher</th><th scope=col>lamb</th><th scope=col>larg</th><th scope=col>leaf</th><th scope=col>lean</th><th scope=col>leav</th><th scope=col>leek</th><th scope=col>lemon</th><th scope=col>less</th><th scope=col>lettuc</th><th scope=col>light</th><th scope=col>lime</th><th scope=col>low</th><th scope=col>low-fat</th><th scope=col>masala</th><th scope=col>mayonais</th><th scope=col>meat</th><th scope=col>medium</th><th scope=col>mexican</th><th scope=col>milk</th><th scope=col>minc</th><th scope=col>mint</th><th scope=col>mirin</th><th scope=col>mix</th><th scope=col>monterey</th><th scope=col>mozzarella</th><th scope=col>mushroom</th><th scope=col>mustard</th><th scope=col>noodl</th><th scope=col>nutmeg</th><th scope=col>oil</th><th scope=col>oliv</th><th scope=col>onion</th><th scope=col>orang</th><th scope=col>oregano</th><th scope=col>oyster</th><th scope=col>paprika</th><th scope=col>parmesan</th><th scope=col>parsley</th><th scope=col>past</th><th scope=col>pasta</th><th scope=col>pea</th><th scope=col>peanut</th><th scope=col>pecan</th><th scope=col>peel</th><th scope=col>pepper</th><th scope=col>peppercorn</th><th scope=col>plain</th><th scope=col>plum</th><th scope=col>pork</th><th scope=col>potato</th><th scope=col>powder</th><th scope=col>purpl</th><th scope=col>raisin</th><th scope=col>red</th><th scope=col>reduc</th><th scope=col>rib</th><th scope=col>rice</th><th scope=col>ricotta</th><th scope=col>roast</th><th scope=col>root</th><th scope=col>rosemari</th><th scope=col>saffron</th><th scope=col>sage</th><th scope=col>salsa</th><th scope=col>salt</th><th scope=col>sauc</th><th scope=col>sausag</th><th scope=col>scallion</th><th scope=col>sea</th><th scope=col>season</th><th scope=col>seed</th><th scope=col>serrano</th><th scope=col>sesam</th><th scope=col>shallot</th><th scope=col>sharp</th><th scope=col>shell</th><th scope=col>sherri</th><th scope=col>shiitak</th><th scope=col>shoulder</th><th scope=col>shred</th><th scope=col>shrimp</th><th scope=col>skinless</th><th scope=col>slice</th><th scope=col>smoke</th><th scope=col>soda</th><th scope=col>sodium</th><th scope=col>soup</th><th scope=col>sour</th><th scope=col>soy</th><th scope=col>spaghetti</th><th scope=col>spinach</th><th scope=col>spray</th><th scope=col>sprig</th><th scope=col>spring</th><th scope=col>squash</th><th scope=col>starch</th><th scope=col>steak</th><th scope=col>stick</th><th scope=col>stock</th><th scope=col>sugar</th><th scope=col>sweet</th><th scope=col>sweeten</th><th scope=col>syrup</th><th scope=col>taco</th><th scope=col>thai</th><th scope=col>thigh</th><th scope=col>thyme</th><th scope=col>toast</th><th scope=col>tofu</th><th scope=col>tomato</th><th scope=col>tortilla</th><th scope=col>tumer</th><th scope=col>turkey</th><th scope=col>turmer</th><th scope=col>unsalt</th><th scope=col>unsweeten</th><th scope=col>vanilla</th><th scope=col>veget</th><th scope=col>vinegar</th><th scope=col>warm</th><th scope=col>water</th><th scope=col>wedg</th><th scope=col>wheat</th><th scope=col>whip</th><th scope=col>white</th><th scope=col>whole</th><th scope=col>wine</th><th scope=col>worcestershir</th><th scope=col>yeast</th><th scope=col>yellow</th><th scope=col>yogurt</th><th scope=col>yolk</th><th scope=col>zest</th><th scope=col>zucchini</th><th scope=col>cuisine</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>greek</td></tr>
	<tr><th scope=row>2</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>southern_us</td></tr>
	<tr><th scope=row>3</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>filipino</td></tr>
	<tr><th scope=row>4</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>indian</td></tr>
	<tr><th scope=row>5</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>indian</td></tr>
	<tr><th scope=row>6</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>jamaican</td></tr>
</tbody>
</table>





```R
inTrain <- createDataPartition(y = ingredientsDTM_train$cuisine, p = 0.6, list = FALSE)
train_data <- ingredientsDTM_train[inTrain,]
vaild_data <- ingredientsDTM_train[-inTrain,]
```


```R
test_data <- ingredientsDTM_test
```


```R
dim(train_data)
dim(vaild_data)
```




<ol class=list-inline>
	<li>23871</li>
	<li>251</li>
</ol>







<ol class=list-inline>
	<li>15903</li>
	<li>251</li>
</ol>





```R
ingredients_sum <- apply(rbind(ingredientsDTM_train[,-251], ingredientsDTM_test[,-251]), 2, sum)
```


```R
head(ingredients_sum)
```




<dl class=dl-horizontal>
	<dt>all-purpos</dt>
		<dd>5820</dd>
	<dt>allspic</dt>
		<dd>682</dd>
	<dt>almond</dt>
		<dd>1452</dd>
	<dt>and</dt>
		<dd>622</dd>
	<dt>appl</dt>
		<dd>1036</dd>
	<dt>avocado</dt>
		<dd>1614</dd>
</dl>





```R
ingredients_sum <- ingredients_sum[order(ingredients_sum, decreasing=T)]
```


```R
names(ingredients_sum)
```




<ol class=list-inline>
	<li>"pepper"</li>
	<li>"salt"</li>
	<li>"oil"</li>
	<li>"onion"</li>
	<li>"garlic"</li>
	<li>"fresh"</li>
	<li>"ground"</li>
	<li>"sauc"</li>
	<li>"sugar"</li>
	<li>"oliv"</li>
	<li>"chees"</li>
	<li>"chicken"</li>
	<li>"tomato"</li>
	<li>"black"</li>
	<li>"water"</li>
	<li>"red"</li>
	<li>"green"</li>
	<li>"egg"</li>
	<li>"flour"</li>
	<li>"powder"</li>
	<li>"butter"</li>
	<li>"dri"</li>
	<li>"chop"</li>
	<li>"clove"</li>
	<li>"white"</li>
	<li>"juic"</li>
	<li>"chili"</li>
	<li>"cream"</li>
	<li>"rice"</li>
	<li>"cilantro"</li>
	<li>"veget"</li>
	<li>"milk"</li>
	<li>"lemon"</li>
	<li>"leav"</li>
	<li>"larg"</li>
	<li>"ginger"</li>
	<li>"corn"</li>
	<li>"vinegar"</li>
	<li>"lime"</li>
	<li>"soy"</li>
	<li>"all-purpos"</li>
	<li>"cumin"</li>
	<li>"broth"</li>
	<li>"bell"</li>
	<li>"wine"</li>
	<li>"parsley"</li>
	<li>"seed"</li>
	<li>"bean"</li>
	<li>"cook"</li>
	<li>"sesam"</li>
	<li>"grate"</li>
	<li>"breast"</li>
	<li>"carrot"</li>
	<li>"kosher"</li>
	<li>"basil"</li>
	<li>"beef"</li>
	<li>"bake"</li>
	<li>"brown"</li>
	<li>"chile"</li>
	<li>"past"</li>
	<li>"unsalt"</li>
	<li>"potato"</li>
	<li>"parmesan"</li>
	<li>"oregano"</li>
	<li>"extra-virgin"</li>
	<li>"boneless"</li>
	<li>"shred"</li>
	<li>"tortilla"</li>
	<li>"cinnamon"</li>
	<li>"season"</li>
	<li>"thyme"</li>
	<li>"pork"</li>
	<li>"mushroom"</li>
	<li>"shrimp"</li>
	<li>"dice"</li>
	<li>"yellow"</li>
	<li>"bread"</li>
	<li>"skinless"</li>
	<li>"vanilla"</li>
	<li>"coconut"</li>
	<li>"sodium"</li>
	<li>"coriand"</li>
	<li>"celeri"</li>
	<li>"bay"</li>
	<li>"cayenn"</li>
	<li>"minc"</li>
	<li>"leaf"</li>
	<li>"crush"</li>
	<li>"whole"</li>
	<li>"spray"</li>
	<li>"flake"</li>
	<li>"sour"</li>
	<li>"scallion"</li>
	<li>"slice"</li>
	<li>"starch"</li>
	<li>"paprika"</li>
	<li>"stock"</li>
	<li>"hot"</li>
	<li>"purpl"</li>
	<li>"cheddar"</li>
	<li>"fish"</li>
	<li>"orang"</li>
	<li>"mustard"</li>
	<li>"jalapeno"</li>
	<li>"extract"</li>
	<li>"peanut"</li>
	<li>"curri"</li>
	<li>"sausag"</li>
	<li>"frozen"</li>
	<li>"sweet"</li>
	<li>"low"</li>
	<li>"shallot"</li>
	<li>"sea"</li>
	<li>"pea"</li>
	<li>"fat"</li>
	<li>"light"</li>
	<li>"mozzarella"</li>
	<li>"honey"</li>
	<li>"heavi"</li>
	<li>"noodl"</li>
	<li>"italian"</li>
	<li>"mint"</li>
	<li>"spinach"</li>
	<li>"salsa"</li>
	<li>"roast"</li>
	<li>"canola"</li>
	<li>"avocado"</li>
	<li>"peel"</li>
	<li>"cabbag"</li>
	<li>"pasta"</li>
	<li>"bacon"</li>
	<li>"lettuc"</li>
	<li>"yogurt"</li>
	<li>"cucumb"</li>
	<li>"almond"</li>
	<li>"yolk"</li>
	<li>"fillet"</li>
	<li>"flat"</li>
	<li>"whip"</li>
	<li>"masala"</li>
	<li>"nutmeg"</li>
	<li>"dark"</li>
	<li>"soda"</li>
	<li>"granul"</li>
	<li>"buttermilk"</li>
	<li>"crumb"</li>
	<li>"halv"</li>
	<li>"turmer"</li>
	<li>"plum"</li>
	<li>"rib"</li>
	<li>"jack"</li>
	<li>"garam"</li>
	<li>"steak"</li>
	<li>"zucchini"</li>
	<li>"fine"</li>
	<li>"zest"</li>
	<li>"plain"</li>
	<li>"toast"</li>
	<li>"mix"</li>
	<li>"chocol"</li>
	<li>"free"</li>
	<li>"smoke"</li>
	<li>"thigh"</li>
	<li>"peppercorn"</li>
	<li>"appl"</li>
	<li>"rosemari"</li>
	<li>"sprig"</li>
	<li>"mayonais"</li>
	<li>"babi"</li>
	<li>"tumer"</li>
	<li>"yeast"</li>
	<li>"stick"</li>
	<li>"reduc"</li>
	<li>"cardamom"</li>
	<li>"thai"</li>
	<li>"ricotta"</li>
	<li>"chines"</li>
	<li>"coars"</li>
	<li>"wedg"</li>
	<li>"raisin"</li>
	<li>"low-fat"</li>
	<li>"worcestershir"</li>
	<li>"ham"</li>
	<li>"cider"</li>
	<li>"feta"</li>
	<li>"fennel"</li>
	<li>"cherri"</li>
	<li>"kernel"</li>
	<li>"meat"</li>
	<li>"taco"</li>
	<li>"tofu"</li>
	<li>"sherri"</li>
	<li>"turkey"</li>
	<li>"chive"</li>
	<li>"wheat"</li>
	<li>"ice"</li>
	<li>"syrup"</li>
	<li>"eggplant"</li>
	<li>"pecan"</li>
	<li>"warm"</li>
	<li>"medium"</li>
	<li>"shiitak"</li>
	<li>"balsam"</li>
	<li>"monterey"</li>
	<li>"lamb"</li>
	<li>"oyster"</li>
	<li>"chipotl"</li>
	<li>"dijon"</li>
	<li>"root"</li>
	<li>"chip"</li>
	<li>"serrano"</li>
	<li>"lean"</li>
	<li>"less"</li>
	<li>"unsweeten"</li>
	<li>"allspic"</li>
	<li>"condens"</li>
	<li>"caper"</li>
	<li>"cold"</li>
	<li>"firm"</li>
	<li>"broccoli"</li>
	<li>"mexican"</li>
	<li>"ketchup"</li>
	<li>"boil"</li>
	<li>"cornmeal"</li>
	<li>"crumbl"</li>
	<li>"mirin"</li>
	<li>"and"</li>
	<li>"greek"</li>
	<li>"saffron"</li>
	<li>"spring"</li>
	<li>"soup"</li>
	<li>"sharp"</li>
	<li>"chickpea"</li>
	<li>"beansprout"</li>
	<li>"dough"</li>
	<li>"leek"</li>
	<li>"sage"</li>
	<li>"squash"</li>
	<li>"dill"</li>
	<li>"sweeten"</li>
	<li>"spaghetti"</li>
	<li>"dress"</li>
	<li>"shoulder"</li>
	<li>"golden"</li>
	<li>"hoisin"</li>
	<li>"enchilada"</li>
	<li>"kalamata"</li>
	<li>"crack"</li>
	<li>"shell"</li>
	<li>"confection"</li>
</ol>





```R
plot(ingredients_sum[1:15], xaxt='n')
axis(side=1, at=1:15, labels=names(ingredients_sum[1:15]), col.axis="blue", cex.axis=0.5)
```




```R
barplot(ingredients_sum[1:15], las=2)
```



### 상위 15개 재료 
- pepper, salt, oil, onion, garlic, fresh, ground, sauc, sugar, oliv, chees, chicken, tomato, black, water)
- 후추, 소금, 기름, 양파, 마늘... 


```R
barplot(ingredients_sum[30:50], las=2)
```




```R
aggregate(ingredientsDTM_train[,c(1:250)], list(ingredientsDTM_train[,251]), sum)
```




<table>
<thead><tr><th></th><th scope=col>Group.1</th><th scope=col>all-purpos</th><th scope=col>allspic</th><th scope=col>almond</th><th scope=col>and</th><th scope=col>appl</th><th scope=col>avocado</th><th scope=col>babi</th><th scope=col>bacon</th><th scope=col>bake</th><th scope=col>balsam</th><th scope=col>basil</th><th scope=col>bay</th><th scope=col>bean</th><th scope=col>beansprout</th><th scope=col>beef</th><th scope=col>bell</th><th scope=col>black</th><th scope=col>boil</th><th scope=col>boneless</th><th scope=col>bread</th><th scope=col>breast</th><th scope=col>broccoli</th><th scope=col>broth</th><th scope=col>brown</th><th scope=col>butter</th><th scope=col>buttermilk</th><th scope=col>cabbag</th><th scope=col>canola</th><th scope=col>caper</th><th scope=col>cardamom</th><th scope=col>carrot</th><th scope=col>cayenn</th><th scope=col>celeri</th><th scope=col>cheddar</th><th scope=col>chees</th><th scope=col>cherri</th><th scope=col>chicken</th><th scope=col>chickpea</th><th scope=col>chile</th><th scope=col>chili</th><th scope=col>chines</th><th scope=col>chip</th><th scope=col>chipotl</th><th scope=col>chive</th><th scope=col>chocol</th><th scope=col>chop</th><th scope=col>cider</th><th scope=col>cilantro</th><th scope=col>cinnamon</th><th scope=col>clove</th><th scope=col>coars</th><th scope=col>coconut</th><th scope=col>cold</th><th scope=col>condens</th><th scope=col>confection</th><th scope=col>cook</th><th scope=col>coriand</th><th scope=col>corn</th><th scope=col>cornmeal</th><th scope=col>crack</th><th scope=col>cream</th><th scope=col>crumb</th><th scope=col>crumbl</th><th scope=col>crush</th><th scope=col>cucumb</th><th scope=col>cumin</th><th scope=col>curri</th><th scope=col>dark</th><th scope=col>dice</th><th scope=col>dijon</th><th scope=col>dill</th><th scope=col>dough</th><th scope=col>dress</th><th scope=col>dri</th><th scope=col>egg</th><th scope=col>eggplant</th><th scope=col>enchilada</th><th scope=col>extra-virgin</th><th scope=col>extract</th><th scope=col>fat</th><th scope=col>fennel</th><th scope=col>feta</th><th scope=col>fillet</th><th scope=col>fine</th><th scope=col>firm</th><th scope=col>fish</th><th scope=col>flake</th><th scope=col>flat</th><th scope=col>flour</th><th scope=col>free</th><th scope=col>fresh</th><th scope=col>frozen</th><th scope=col>garam</th><th scope=col>garlic</th><th scope=col>ginger</th><th scope=col>golden</th><th scope=col>granul</th><th scope=col>grate</th><th scope=col>greek</th><th scope=col>green</th><th scope=col>ground</th><th scope=col>halv</th><th scope=col>ham</th><th scope=col>heavi</th><th scope=col>hoisin</th><th scope=col>honey</th><th scope=col>hot</th><th scope=col>ice</th><th scope=col>italian</th><th scope=col>jack</th><th scope=col>jalapeno</th><th scope=col>juic</th><th scope=col>kalamata</th><th scope=col>kernel</th><th scope=col>ketchup</th><th scope=col>kosher</th><th scope=col>lamb</th><th scope=col>larg</th><th scope=col>leaf</th><th scope=col>lean</th><th scope=col>leav</th><th scope=col>leek</th><th scope=col>lemon</th><th scope=col>less</th><th scope=col>lettuc</th><th scope=col>light</th><th scope=col>lime</th><th scope=col>low</th><th scope=col>low-fat</th><th scope=col>masala</th><th scope=col>mayonais</th><th scope=col>meat</th><th scope=col>medium</th><th scope=col>mexican</th><th scope=col>milk</th><th scope=col>minc</th><th scope=col>mint</th><th scope=col>mirin</th><th scope=col>mix</th><th scope=col>monterey</th><th scope=col>mozzarella</th><th scope=col>mushroom</th><th scope=col>mustard</th><th scope=col>noodl</th><th scope=col>nutmeg</th><th scope=col>oil</th><th scope=col>oliv</th><th scope=col>onion</th><th scope=col>orang</th><th scope=col>oregano</th><th scope=col>oyster</th><th scope=col>paprika</th><th scope=col>parmesan</th><th scope=col>parsley</th><th scope=col>past</th><th scope=col>pasta</th><th scope=col>pea</th><th scope=col>peanut</th><th scope=col>pecan</th><th scope=col>peel</th><th scope=col>pepper</th><th scope=col>peppercorn</th><th scope=col>plain</th><th scope=col>plum</th><th scope=col>pork</th><th scope=col>potato</th><th scope=col>powder</th><th scope=col>purpl</th><th scope=col>raisin</th><th scope=col>red</th><th scope=col>reduc</th><th scope=col>rib</th><th scope=col>rice</th><th scope=col>ricotta</th><th scope=col>roast</th><th scope=col>root</th><th scope=col>rosemari</th><th scope=col>saffron</th><th scope=col>sage</th><th scope=col>salsa</th><th scope=col>salt</th><th scope=col>sauc</th><th scope=col>sausag</th><th scope=col>scallion</th><th scope=col>sea</th><th scope=col>season</th><th scope=col>seed</th><th scope=col>serrano</th><th scope=col>sesam</th><th scope=col>shallot</th><th scope=col>sharp</th><th scope=col>shell</th><th scope=col>sherri</th><th scope=col>shiitak</th><th scope=col>shoulder</th><th scope=col>shred</th><th scope=col>shrimp</th><th scope=col>skinless</th><th scope=col>slice</th><th scope=col>smoke</th><th scope=col>soda</th><th scope=col>sodium</th><th scope=col>soup</th><th scope=col>sour</th><th scope=col>soy</th><th scope=col>spaghetti</th><th scope=col>spinach</th><th scope=col>spray</th><th scope=col>sprig</th><th scope=col>spring</th><th scope=col>squash</th><th scope=col>starch</th><th scope=col>steak</th><th scope=col>stick</th><th scope=col>stock</th><th scope=col>sugar</th><th scope=col>sweet</th><th scope=col>sweeten</th><th scope=col>syrup</th><th scope=col>taco</th><th scope=col>thai</th><th scope=col>thigh</th><th scope=col>thyme</th><th scope=col>toast</th><th scope=col>tofu</th><th scope=col>tomato</th><th scope=col>tortilla</th><th scope=col>tumer</th><th scope=col>turkey</th><th scope=col>turmer</th><th scope=col>unsalt</th><th scope=col>unsweeten</th><th scope=col>vanilla</th><th scope=col>veget</th><th scope=col>vinegar</th><th scope=col>warm</th><th scope=col>water</th><th scope=col>wedg</th><th scope=col>wheat</th><th scope=col>whip</th><th scope=col>white</th><th scope=col>whole</th><th scope=col>wine</th><th scope=col>worcestershir</th><th scope=col>yeast</th><th scope=col>yellow</th><th scope=col>yogurt</th><th scope=col>yolk</th><th scope=col>zest</th><th scope=col>zucchini</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>brazilian</td><td>18</td><td>1</td><td>24</td><td>2</td><td>10</td><td>10</td><td>3</td><td>30</td><td>19</td><td>0</td><td>2</td><td>54</td><td>71</td><td>0</td><td>31</td><td>80</td><td>133</td><td>4</td><td>16</td><td>13</td><td>17</td><td>0</td><td>33</td><td>21</td><td>83</td><td>2</td><td>0</td><td>13</td><td>1</td><td>0</td><td>26</td><td>23</td><td>7</td><td>5</td><td>56</td><td>5</td><td>76</td><td>0</td><td>23</td><td>41</td><td>0</td><td>4</td><td>5</td><td>2</td><td>35</td><td>76</td><td>2</td><td>88</td><td>14</td><td>92</td><td>7</td><td>142</td><td>12</td><td>68</td><td>1</td><td>28</td><td>22</td><td>34</td><td>4</td><td>3</td><td>35</td><td>9</td><td>0</td><td>32</td><td>2</td><td>29</td><td>2</td><td>5</td><td>21</td><td>4</td><td>0</td><td>1</td><td>0</td><td>62</td><td>105</td><td>0</td><td>0</td><td>13</td><td>18</td><td>5</td><td>3</td><td>0</td><td>25</td><td>8</td><td>0</td><td>27</td><td>33</td><td>10</td><td>73</td><td>5</td><td>133</td><td>32</td><td>1</td><td>194</td><td>31</td><td>1</td><td>21</td><td>21</td><td>0</td><td>85</td><td>126</td><td>3</td><td>17</td><td>7</td><td>0</td><td>12</td><td>22</td><td>57</td><td>5</td><td>3</td><td>19</td><td>104</td><td>0</td><td>4</td><td>1</td><td>22</td><td>2</td><td>33</td><td>33</td><td>1</td><td>63</td><td>2</td><td>37</td><td>3</td><td>1</td><td>16</td><td>164</td><td>10</td><td>5</td><td>1</td><td>10</td><td>3</td><td>10</td><td>0</td><td>229</td><td>15</td><td>7</td><td>0</td><td>6</td><td>2</td><td>5</td><td>2</td><td>5</td><td>0</td><td>5</td><td>247</td><td>145</td><td>226</td><td>50</td><td>14</td><td>1</td><td>19</td><td>24</td><td>55</td><td>21</td><td>1</td><td>16</td><td>10</td><td>3</td><td>6</td><td>310</td><td>1</td><td>3</td><td>9</td><td>35</td><td>26</td><td>63</td><td>8</td><td>6</td><td>86</td><td>2</td><td>18</td><td>63</td><td>0</td><td>11</td><td>4</td><td>2</td><td>3</td><td>1</td><td>7</td><td>246</td><td>35</td><td>30</td><td>8</td><td>19</td><td>7</td><td>26</td><td>7</td><td>2</td><td>5</td><td>1</td><td>2</td><td>3</td><td>0</td><td>9</td><td>15</td><td>58</td><td>10</td><td>22</td><td>16</td><td>8</td><td>16</td><td>2</td><td>6</td><td>3</td><td>0</td><td>6</td><td>3</td><td>1</td><td>4</td><td>2</td><td>22</td><td>12</td><td>4</td><td>29</td><td>150</td><td>18</td><td>61</td><td>16</td><td>0</td><td>1</td><td>6</td><td>13</td><td>5</td><td>1</td><td>133</td><td>1</td><td>3</td><td>5</td><td>4</td><td>26</td><td>29</td><td>28</td><td>46</td><td>26</td><td>2</td><td>112</td><td>15</td><td>3</td><td>4</td><td>91</td><td>15</td><td>30</td><td>2</td><td>6</td><td>34</td><td>3</td><td>22</td><td>8</td><td>3</td></tr>
	<tr><th scope=row>2</th><td>british</td><td>238</td><td>27</td><td>44</td><td>3</td><td>30</td><td>0</td><td>2</td><td>25</td><td>217</td><td>17</td><td>5</td><td>42</td><td>15</td><td>0</td><td>158</td><td>4</td><td>134</td><td>18</td><td>3</td><td>81</td><td>4</td><td>1</td><td>36</td><td>109</td><td>436</td><td>26</td><td>10</td><td>18</td><td>4</td><td>2</td><td>61</td><td>32</td><td>26</td><td>60</td><td>108</td><td>16</td><td>30</td><td>0</td><td>1</td><td>8</td><td>0</td><td>4</td><td>0</td><td>18</td><td>32</td><td>66</td><td>9</td><td>5</td><td>68</td><td>57</td><td>17</td><td>6</td><td>22</td><td>11</td><td>22</td><td>23</td><td>7</td><td>57</td><td>11</td><td>13</td><td>268</td><td>37</td><td>1</td><td>7</td><td>4</td><td>8</td><td>19</td><td>44</td><td>3</td><td>22</td><td>5</td><td>12</td><td>0</td><td>157</td><td>436</td><td>0</td><td>0</td><td>19</td><td>85</td><td>10</td><td>3</td><td>0</td><td>35</td><td>12</td><td>2</td><td>14</td><td>14</td><td>6</td><td>467</td><td>12</td><td>180</td><td>57</td><td>2</td><td>94</td><td>54</td><td>53</td><td>37</td><td>54</td><td>4</td><td>26</td><td>312</td><td>4</td><td>7</td><td>104</td><td>0</td><td>16</td><td>16</td><td>15</td><td>2</td><td>0</td><td>1</td><td>65</td><td>0</td><td>1</td><td>7</td><td>61</td><td>14</td><td>164</td><td>26</td><td>20</td><td>48</td><td>18</td><td>125</td><td>0</td><td>3</td><td>40</td><td>5</td><td>8</td><td>8</td><td>2</td><td>7</td><td>8</td><td>14</td><td>0</td><td>287</td><td>16</td><td>14</td><td>0</td><td>32</td><td>0</td><td>0</td><td>58</td><td>76</td><td>0</td><td>70</td><td>201</td><td>77</td><td>215</td><td>55</td><td>8</td><td>0</td><td>22</td><td>11</td><td>52</td><td>29</td><td>0</td><td>30</td><td>2</td><td>12</td><td>35</td><td>276</td><td>10</td><td>39</td><td>4</td><td>46</td><td>144</td><td>213</td><td>11</td><td>62</td><td>50</td><td>2</td><td>16</td><td>23</td><td>0</td><td>18</td><td>2</td><td>23</td><td>2</td><td>21</td><td>0</td><td>516</td><td>83</td><td>42</td><td>4</td><td>26</td><td>11</td><td>23</td><td>1</td><td>1</td><td>19</td><td>20</td><td>6</td><td>23</td><td>1</td><td>6</td><td>12</td><td>3</td><td>4</td><td>23</td><td>17</td><td>85</td><td>9</td><td>3</td><td>23</td><td>5</td><td>0</td><td>5</td><td>12</td><td>10</td><td>4</td><td>2</td><td>32</td><td>26</td><td>9</td><td>49</td><td>454</td><td>21</td><td>11</td><td>41</td><td>0</td><td>1</td><td>0</td><td>62</td><td>7</td><td>0</td><td>53</td><td>0</td><td>9</td><td>2</td><td>3</td><td>193</td><td>2</td><td>119</td><td>82</td><td>71</td><td>15</td><td>178</td><td>8</td><td>15</td><td>82</td><td>168</td><td>77</td><td>66</td><td>53</td><td>41</td><td>26</td><td>8</td><td>67</td><td>21</td><td>3</td></tr>
	<tr><th scope=row>3</th><td>cajun_creole</td><td>291</td><td>18</td><td>12</td><td>39</td><td>14</td><td>4</td><td>17</td><td>62</td><td>64</td><td>8</td><td>94</td><td>360</td><td>164</td><td>0</td><td>79</td><td>696</td><td>496</td><td>23</td><td>152</td><td>133</td><td>176</td><td>3</td><td>348</td><td>111</td><td>498</td><td>33</td><td>15</td><td>84</td><td>30</td><td>1</td><td>53</td><td>399</td><td>619</td><td>20</td><td>174</td><td>9</td><td>741</td><td>3</td><td>28</td><td>142</td><td>0</td><td>5</td><td>3</td><td>22</td><td>11</td><td>544</td><td>19</td><td>26</td><td>46</td><td>329</td><td>29</td><td>9</td><td>10</td><td>17</td><td>26</td><td>299</td><td>10</td><td>145</td><td>23</td><td>24</td><td>206</td><td>49</td><td>5</td><td>89</td><td>0</td><td>57</td><td>1</td><td>14</td><td>277</td><td>33</td><td>13</td><td>5</td><td>18</td><td>646</td><td>237</td><td>4</td><td>0</td><td>47</td><td>54</td><td>51</td><td>9</td><td>1</td><td>75</td><td>41</td><td>4</td><td>12</td><td>69</td><td>50</td><td>450</td><td>31</td><td>546</td><td>52</td><td>0</td><td>1003</td><td>6</td><td>6</td><td>51</td><td>58</td><td>0</td><td>913</td><td>679</td><td>61</td><td>94</td><td>74</td><td>0</td><td>14</td><td>286</td><td>15</td><td>45</td><td>16</td><td>50</td><td>196</td><td>3</td><td>27</td><td>23</td><td>108</td><td>0</td><td>223</td><td>158</td><td>13</td><td>297</td><td>7</td><td>253</td><td>24</td><td>40</td><td>42</td><td>23</td><td>76</td><td>17</td><td>0</td><td>80</td><td>73</td><td>109</td><td>2</td><td>165</td><td>121</td><td>3</td><td>0</td><td>46</td><td>8</td><td>11</td><td>83</td><td>133</td><td>6</td><td>26</td><td>821</td><td>402</td><td>1314</td><td>36</td><td>225</td><td>30</td><td>262</td><td>58</td><td>369</td><td>99</td><td>27</td><td>32</td><td>31</td><td>40</td><td>39</td><td>2326</td><td>17</td><td>6</td><td>26</td><td>61</td><td>58</td><td>450</td><td>38</td><td>9</td><td>555</td><td>36</td><td>183</td><td>537</td><td>1</td><td>33</td><td>0</td><td>27</td><td>2</td><td>16</td><td>2</td><td>993</td><td>665</td><td>463</td><td>97</td><td>36</td><td>631</td><td>34</td><td>4</td><td>1</td><td>23</td><td>7</td><td>15</td><td>8</td><td>1</td><td>6</td><td>25</td><td>473</td><td>125</td><td>100</td><td>198</td><td>26</td><td>107</td><td>35</td><td>25</td><td>14</td><td>5</td><td>18</td><td>75</td><td>26</td><td>2</td><td>8</td><td>28</td><td>16</td><td>6</td><td>148</td><td>310</td><td>76</td><td>7</td><td>18</td><td>1</td><td>0</td><td>55</td><td>428</td><td>8</td><td>1</td><td>673</td><td>6</td><td>1</td><td>62</td><td>1</td><td>119</td><td>3</td><td>74</td><td>313</td><td>72</td><td>24</td><td>340</td><td>16</td><td>5</td><td>41</td><td>371</td><td>77</td><td>105</td><td>195</td><td>56</td><td>146</td><td>3</td><td>34</td><td>13</td><td>13</td></tr>
	<tr><th scope=row>4</th><td>chinese</td><td>129</td><td>0</td><td>46</td><td>36</td><td>26</td><td>9</td><td>92</td><td>26</td><td>100</td><td>32</td><td>34</td><td>14</td><td>330</td><td>109</td><td>167</td><td>261</td><td>529</td><td>56</td><td>391</td><td>15</td><td>460</td><td>171</td><td>368</td><td>363</td><td>112</td><td>2</td><td>251</td><td>187</td><td>0</td><td>5</td><td>379</td><td>36</td><td>113</td><td>2</td><td>33</td><td>12</td><td>1330</td><td>1</td><td>147</td><td>588</td><td>604</td><td>0</td><td>1</td><td>63</td><td>4</td><td>217</td><td>47</td><td>245</td><td>65</td><td>497</td><td>44</td><td>44</td><td>91</td><td>9</td><td>9</td><td>355</td><td>50</td><td>1005</td><td>2</td><td>12</td><td>54</td><td>6</td><td>2</td><td>157</td><td>61</td><td>16</td><td>23</td><td>364</td><td>21</td><td>8</td><td>1</td><td>8</td><td>9</td><td>395</td><td>697</td><td>37</td><td>0</td><td>12</td><td>25</td><td>56</td><td>16</td><td>1</td><td>45</td><td>22</td><td>112</td><td>89</td><td>237</td><td>2</td><td>375</td><td>54</td><td>1048</td><td>95</td><td>1</td><td>1687</td><td>1483</td><td>7</td><td>52</td><td>29</td><td>1</td><td>987</td><td>788</td><td>73</td><td>30</td><td>6</td><td>326</td><td>257</td><td>109</td><td>11</td><td>3</td><td>0</td><td>20</td><td>222</td><td>0</td><td>9</td><td>131</td><td>187</td><td>11</td><td>256</td><td>16</td><td>42</td><td>155</td><td>29</td><td>106</td><td>43</td><td>91</td><td>298</td><td>79</td><td>304</td><td>1</td><td>1</td><td>12</td><td>47</td><td>62</td><td>1</td><td>74</td><td>325</td><td>14</td><td>27</td><td>33</td><td>0</td><td>1</td><td>357</td><td>39</td><td>320</td><td>10</td><td>3005</td><td>151</td><td>1300</td><td>192</td><td>2</td><td>352</td><td>14</td><td>4</td><td>17</td><td>227</td><td>7</td><td>246</td><td>473</td><td>0</td><td>202</td><td>1733</td><td>177</td><td>16</td><td>35</td><td>557</td><td>43</td><td>464</td><td>33</td><td>5</td><td>758</td><td>106</td><td>66</td><td>1249</td><td>1</td><td>131</td><td>141</td><td>1</td><td>0</td><td>3</td><td>1</td><td>1237</td><td>3450</td><td>30</td><td>608</td><td>69</td><td>38</td><td>325</td><td>15</td><td>1488</td><td>73</td><td>1</td><td>7</td><td>197</td><td>204</td><td>30</td><td>73</td><td>251</td><td>329</td><td>137</td><td>5</td><td>53</td><td>457</td><td>14</td><td>16</td><td>2244</td><td>24</td><td>36</td><td>52</td><td>15</td><td>171</td><td>6</td><td>952</td><td>131</td><td>50</td><td>229</td><td>1419</td><td>84</td><td>9</td><td>25</td><td>1</td><td>39</td><td>87</td><td>10</td><td>249</td><td>177</td><td>111</td><td>12</td><td>0</td><td>23</td><td>6</td><td>48</td><td>8</td><td>22</td><td>724</td><td>870</td><td>34</td><td>1129</td><td>10</td><td>24</td><td>6</td><td>867</td><td>28</td><td>693</td><td>39</td><td>33</td><td>83</td><td>2</td><td>21</td><td>33</td><td>32</td></tr>
	<tr><th scope=row>5</th><td>filipino</td><td>33</td><td>1</td><td>2</td><td>17</td><td>24</td><td>3</td><td>5</td><td>4</td><td>30</td><td>3</td><td>2</td><td>122</td><td>70</td><td>10</td><td>97</td><td>70</td><td>208</td><td>6</td><td>37</td><td>21</td><td>40</td><td>9</td><td>64</td><td>90</td><td>88</td><td>0</td><td>67</td><td>27</td><td>0</td><td>1</td><td>134</td><td>8</td><td>36</td><td>15</td><td>35</td><td>2</td><td>247</td><td>1</td><td>36</td><td>63</td><td>18</td><td>0</td><td>3</td><td>2</td><td>4</td><td>35</td><td>25</td><td>18</td><td>8</td><td>94</td><td>5</td><td>149</td><td>5</td><td>42</td><td>4</td><td>122</td><td>5</td><td>80</td><td>0</td><td>1</td><td>57</td><td>13</td><td>0</td><td>21</td><td>5</td><td>8</td><td>5</td><td>12</td><td>7</td><td>1</td><td>0</td><td>1</td><td>1</td><td>37</td><td>181</td><td>27</td><td>0</td><td>5</td><td>30</td><td>3</td><td>1</td><td>0</td><td>14</td><td>7</td><td>6</td><td>108</td><td>24</td><td>2</td><td>99</td><td>2</td><td>77</td><td>22</td><td>0</td><td>504</td><td>110</td><td>3</td><td>25</td><td>14</td><td>0</td><td>169</td><td>269</td><td>6</td><td>7</td><td>4</td><td>10</td><td>13</td><td>20</td><td>14</td><td>2</td><td>0</td><td>12</td><td>58</td><td>0</td><td>4</td><td>24</td><td>21</td><td>2</td><td>29</td><td>28</td><td>5</td><td>140</td><td>3</td><td>61</td><td>1</td><td>4</td><td>12</td><td>28</td><td>18</td><td>0</td><td>0</td><td>12</td><td>23</td><td>6</td><td>0</td><td>191</td><td>44</td><td>1</td><td>0</td><td>1</td><td>0</td><td>1</td><td>21</td><td>6</td><td>48</td><td>1</td><td>476</td><td>57</td><td>466</td><td>10</td><td>5</td><td>33</td><td>11</td><td>2</td><td>11</td><td>30</td><td>6</td><td>32</td><td>18</td><td>0</td><td>6</td><td>511</td><td>90</td><td>3</td><td>4</td><td>212</td><td>65</td><td>90</td><td>13</td><td>26</td><td>72</td><td>1</td><td>15</td><td>128</td><td>0</td><td>3</td><td>11</td><td>0</td><td>3</td><td>0</td><td>1</td><td>483</td><td>511</td><td>14</td><td>18</td><td>15</td><td>15</td><td>17</td><td>1</td><td>30</td><td>20</td><td>1</td><td>2</td><td>4</td><td>10</td><td>19</td><td>19</td><td>74</td><td>24</td><td>12</td><td>5</td><td>4</td><td>21</td><td>2</td><td>4</td><td>290</td><td>3</td><td>27</td><td>4</td><td>0</td><td>32</td><td>6</td><td>57</td><td>9</td><td>7</td><td>31</td><td>319</td><td>41</td><td>28</td><td>3</td><td>1</td><td>29</td><td>31</td><td>6</td><td>1</td><td>13</td><td>122</td><td>2</td><td>1</td><td>1</td><td>5</td><td>7</td><td>5</td><td>37</td><td>108</td><td>172</td><td>9</td><td>348</td><td>4</td><td>1</td><td>1</td><td>156</td><td>25</td><td>17</td><td>9</td><td>17</td><td>35</td><td>0</td><td>21</td><td>3</td><td>6</td></tr>
	<tr><th scope=row>6</th><td>french</td><td>594</td><td>38</td><td>176</td><td>16</td><td>127</td><td>3</td><td>42</td><td>145</td><td>129</td><td>35</td><td>159</td><td>303</td><td>246</td><td>0</td><td>172</td><td>112</td><td>725</td><td>52</td><td>80</td><td>265</td><td>109</td><td>13</td><td>305</td><td>113</td><td>1162</td><td>15</td><td>20</td><td>28</td><td>93</td><td>10</td><td>255</td><td>61</td><td>162</td><td>24</td><td>554</td><td>71</td><td>536</td><td>14</td><td>8</td><td>11</td><td>3</td><td>14</td><td>1</td><td>110</td><td>237</td><td>439</td><td>33</td><td>14</td><td>106</td><td>538</td><td>38</td><td>23</td><td>58</td><td>17</td><td>91</td><td>231</td><td>21</td><td>137</td><td>10</td><td>28</td><td>699</td><td>81</td><td>13</td><td>26</td><td>9</td><td>18</td><td>13</td><td>48</td><td>60</td><td>190</td><td>19</td><td>44</td><td>12</td><td>724</td><td>1194</td><td>42</td><td>0</td><td>256</td><td>292</td><td>171</td><td>101</td><td>7</td><td>150</td><td>100</td><td>17</td><td>41</td><td>24</td><td>127</td><td>803</td><td>90</td><td>1457</td><td>93</td><td>0</td><td>777</td><td>44</td><td>45</td><td>124</td><td>287</td><td>5</td><td>229</td><td>866</td><td>69</td><td>75</td><td>247</td><td>1</td><td>72</td><td>42</td><td>98</td><td>40</td><td>7</td><td>1</td><td>459</td><td>54</td><td>5</td><td>2</td><td>159</td><td>34</td><td>863</td><td>283</td><td>5</td><td>420</td><td>139</td><td>527</td><td>59</td><td>59</td><td>93</td><td>39</td><td>76</td><td>77</td><td>0</td><td>47</td><td>21</td><td>17</td><td>0</td><td>484</td><td>62</td><td>55</td><td>1</td><td>26</td><td>6</td><td>11</td><td>234</td><td>255</td><td>12</td><td>140</td><td>1026</td><td>945</td><td>754</td><td>237</td><td>48</td><td>9</td><td>38</td><td>115</td><td>491</td><td>98</td><td>11</td><td>29</td><td>8</td><td>23</td><td>92</td><td>1215</td><td>111</td><td>22</td><td>75</td><td>75</td><td>299</td><td>296</td><td>65</td><td>24</td><td>428</td><td>61</td><td>83</td><td>34</td><td>15</td><td>61</td><td>18</td><td>111</td><td>50</td><td>39</td><td>0</td><td>1644</td><td>96</td><td>31</td><td>18</td><td>211</td><td>21</td><td>84</td><td>2</td><td>4</td><td>322</td><td>7</td><td>31</td><td>76</td><td>22</td><td>24</td><td>52</td><td>48</td><td>56</td><td>143</td><td>32</td><td>18</td><td>121</td><td>22</td><td>56</td><td>7</td><td>4</td><td>38</td><td>203</td><td>189</td><td>3</td><td>30</td><td>93</td><td>61</td><td>21</td><td>122</td><td>1156</td><td>32</td><td>25</td><td>60</td><td>0</td><td>0</td><td>42</td><td>534</td><td>33</td><td>5</td><td>427</td><td>1</td><td>1</td><td>22</td><td>2</td><td>597</td><td>62</td><td>403</td><td>169</td><td>327</td><td>45</td><td>661</td><td>12</td><td>25</td><td>248</td><td>830</td><td>198</td><td>663</td><td>20</td><td>76</td><td>94</td><td>23</td><td>347</td><td>101</td><td>90</td></tr>
	<tr><th scope=row>7</th><td>greek</td><td>100</td><td>32</td><td>29</td><td>15</td><td>5</td><td>6</td><td>34</td><td>3</td><td>69</td><td>26</td><td>76</td><td>38</td><td>67</td><td>0</td><td>55</td><td>121</td><td>398</td><td>8</td><td>69</td><td>124</td><td>101</td><td>3</td><td>70</td><td>14</td><td>167</td><td>3</td><td>2</td><td>12</td><td>30</td><td>2</td><td>32</td><td>29</td><td>32</td><td>7</td><td>578</td><td>55</td><td>229</td><td>32</td><td>5</td><td>14</td><td>0</td><td>9</td><td>0</td><td>14</td><td>8</td><td>272</td><td>6</td><td>10</td><td>125</td><td>323</td><td>24</td><td>3</td><td>5</td><td>1</td><td>9</td><td>106</td><td>16</td><td>11</td><td>0</td><td>22</td><td>54</td><td>40</td><td>255</td><td>45</td><td>264</td><td>49</td><td>3</td><td>2</td><td>70</td><td>17</td><td>174</td><td>55</td><td>25</td><td>517</td><td>206</td><td>64</td><td>0</td><td>229</td><td>32</td><td>46</td><td>21</td><td>448</td><td>21</td><td>32</td><td>1</td><td>0</td><td>44</td><td>66</td><td>136</td><td>35</td><td>891</td><td>43</td><td>0</td><td>630</td><td>7</td><td>7</td><td>17</td><td>113</td><td>216</td><td>164</td><td>650</td><td>35</td><td>2</td><td>7</td><td>0</td><td>72</td><td>16</td><td>0</td><td>16</td><td>2</td><td>2</td><td>446</td><td>154</td><td>1</td><td>1</td><td>88</td><td>136</td><td>149</td><td>91</td><td>20</td><td>142</td><td>8</td><td>644</td><td>12</td><td>82</td><td>14</td><td>6</td><td>24</td><td>38</td><td>0</td><td>16</td><td>7</td><td>12</td><td>0</td><td>89</td><td>82</td><td>168</td><td>0</td><td>13</td><td>1</td><td>13</td><td>26</td><td>27</td><td>3</td><td>48</td><td>825</td><td>916</td><td>563</td><td>46</td><td>403</td><td>0</td><td>32</td><td>49</td><td>258</td><td>39</td><td>41</td><td>12</td><td>1</td><td>8</td><td>28</td><td>865</td><td>6</td><td>151</td><td>52</td><td>21</td><td>94</td><td>99</td><td>186</td><td>12</td><td>301</td><td>6</td><td>12</td><td>64</td><td>11</td><td>29</td><td>2</td><td>63</td><td>2</td><td>3</td><td>0</td><td>747</td><td>62</td><td>3</td><td>21</td><td>39</td><td>65</td><td>35</td><td>1</td><td>12</td><td>29</td><td>2</td><td>6</td><td>6</td><td>0</td><td>16</td><td>14</td><td>40</td><td>66</td><td>58</td><td>8</td><td>17</td><td>24</td><td>4</td><td>24</td><td>6</td><td>6</td><td>110</td><td>93</td><td>27</td><td>4</td><td>7</td><td>10</td><td>20</td><td>32</td><td>24</td><td>146</td><td>16</td><td>2</td><td>4</td><td>0</td><td>0</td><td>11</td><td>71</td><td>6</td><td>0</td><td>496</td><td>5</td><td>0</td><td>14</td><td>5</td><td>62</td><td>1</td><td>35</td><td>55</td><td>172</td><td>16</td><td>185</td><td>19</td><td>32</td><td>3</td><td>175</td><td>56</td><td>199</td><td>3</td><td>15</td><td>45</td><td>280</td><td>28</td><td>70</td><td>49</td></tr>
	<tr><th scope=row>8</th><td>indian</td><td>150</td><td>24</td><td>124</td><td>8</td><td>45</td><td>5</td><td>71</td><td>0</td><td>110</td><td>6</td><td>15</td><td>231</td><td>119</td><td>1</td><td>58</td><td>150</td><td>688</td><td>43</td><td>253</td><td>80</td><td>257</td><td>19</td><td>192</td><td>220</td><td>429</td><td>21</td><td>37</td><td>161</td><td>0</td><td>588</td><td>213</td><td>374</td><td>34</td><td>4</td><td>62</td><td>13</td><td>814</td><td>197</td><td>376</td><td>1544</td><td>2</td><td>3</td><td>2</td><td>7</td><td>5</td><td>763</td><td>28</td><td>1044</td><td>545</td><td>904</td><td>49</td><td>632</td><td>19</td><td>17</td><td>5</td><td>209</td><td>1155</td><td>90</td><td>1</td><td>22</td><td>286</td><td>27</td><td>3</td><td>137</td><td>97</td><td>1563</td><td>862</td><td>14</td><td>157</td><td>7</td><td>6</td><td>16</td><td>3</td><td>228</td><td>133</td><td>62</td><td>0</td><td>53</td><td>19</td><td>115</td><td>151</td><td>5</td><td>69</td><td>79</td><td>35</td><td>27</td><td>137</td><td>8</td><td>531</td><td>70</td><td>1665</td><td>170</td><td>864</td><td>1635</td><td>1475</td><td>52</td><td>19</td><td>95</td><td>141</td><td>931</td><td>2792</td><td>54</td><td>0</td><td>108</td><td>0</td><td>63</td><td>79</td><td>29</td><td>5</td><td>1</td><td>127</td><td>599</td><td>0</td><td>10</td><td>24</td><td>257</td><td>111</td><td>119</td><td>136</td><td>3</td><td>962</td><td>6</td><td>588</td><td>31</td><td>12</td><td>79</td><td>272</td><td>50</td><td>88</td><td>998</td><td>13</td><td>34</td><td>24</td><td>0</td><td>636</td><td>154</td><td>223</td><td>0</td><td>24</td><td>1</td><td>4</td><td>43</td><td>526</td><td>8</td><td>88</td><td>2031</td><td>424</td><td>1844</td><td>23</td><td>3</td><td>2</td><td>243</td><td>4</td><td>47</td><td>619</td><td>3</td><td>288</td><td>99</td><td>2</td><td>187</td><td>1648</td><td>162</td><td>414</td><td>74</td><td>26</td><td>480</td><td>1523</td><td>170</td><td>117</td><td>885</td><td>20</td><td>14</td><td>593</td><td>5</td><td>54</td><td>149</td><td>1</td><td>115</td><td>0</td><td>2</td><td>2402</td><td>141</td><td>1</td><td>36</td><td>116</td><td>16</td><td>1739</td><td>136</td><td>50</td><td>56</td><td>0</td><td>3</td><td>4</td><td>0</td><td>30</td><td>29</td><td>75</td><td>225</td><td>58</td><td>34</td><td>47</td><td>66</td><td>3</td><td>28</td><td>35</td><td>0</td><td>183</td><td>79</td><td>38</td><td>14</td><td>29</td><td>44</td><td>17</td><td>260</td><td>106</td><td>533</td><td>95</td><td>23</td><td>7</td><td>0</td><td>20</td><td>132</td><td>20</td><td>17</td><td>41</td><td>1259</td><td>8</td><td>509</td><td>11</td><td>732</td><td>89</td><td>45</td><td>18</td><td>744</td><td>153</td><td>60</td><td>967</td><td>49</td><td>85</td><td>23</td><td>247</td><td>187</td><td>55</td><td>2</td><td>73</td><td>221</td><td>576</td><td>3</td><td>22</td><td>43</td></tr>
	<tr><th scope=row>9</th><td>irish</td><td>219</td><td>20</td><td>13</td><td>15</td><td>31</td><td>2</td><td>11</td><td>63</td><td>255</td><td>6</td><td>3</td><td>51</td><td>10</td><td>0</td><td>120</td><td>11</td><td>142</td><td>14</td><td>4</td><td>37</td><td>5</td><td>0</td><td>61</td><td>75</td><td>334</td><td>96</td><td>88</td><td>4</td><td>4</td><td>5</td><td>121</td><td>11</td><td>42</td><td>39</td><td>83</td><td>12</td><td>66</td><td>0</td><td>2</td><td>3</td><td>0</td><td>11</td><td>1</td><td>20</td><td>37</td><td>86</td><td>16</td><td>5</td><td>43</td><td>59</td><td>9</td><td>4</td><td>9</td><td>7</td><td>16</td><td>69</td><td>2</td><td>43</td><td>0</td><td>6</td><td>174</td><td>11</td><td>2</td><td>7</td><td>5</td><td>3</td><td>0</td><td>19</td><td>11</td><td>14</td><td>7</td><td>6</td><td>3</td><td>110</td><td>215</td><td>0</td><td>0</td><td>12</td><td>43</td><td>35</td><td>7</td><td>0</td><td>8</td><td>15</td><td>6</td><td>1</td><td>4</td><td>9</td><td>341</td><td>23</td><td>181</td><td>22</td><td>0</td><td>107</td><td>26</td><td>14</td><td>41</td><td>44</td><td>2</td><td>71</td><td>222</td><td>5</td><td>15</td><td>46</td><td>0</td><td>12</td><td>8</td><td>10</td><td>5</td><td>0</td><td>3</td><td>50</td><td>0</td><td>0</td><td>2</td><td>33</td><td>41</td><td>107</td><td>31</td><td>3</td><td>54</td><td>41</td><td>61</td><td>8</td><td>3</td><td>21</td><td>7</td><td>10</td><td>44</td><td>0</td><td>8</td><td>17</td><td>0</td><td>0</td><td>186</td><td>8</td><td>10</td><td>0</td><td>20</td><td>0</td><td>3</td><td>26</td><td>44</td><td>0</td><td>39</td><td>138</td><td>65</td><td>238</td><td>45</td><td>4</td><td>3</td><td>16</td><td>7</td><td>83</td><td>23</td><td>1</td><td>23</td><td>5</td><td>7</td><td>16</td><td>284</td><td>14</td><td>11</td><td>3</td><td>25</td><td>274</td><td>165</td><td>3</td><td>50</td><td>71</td><td>10</td><td>13</td><td>2</td><td>0</td><td>11</td><td>2</td><td>19</td><td>0</td><td>11</td><td>1</td><td>462</td><td>42</td><td>31</td><td>14</td><td>17</td><td>9</td><td>42</td><td>0</td><td>4</td><td>11</td><td>12</td><td>2</td><td>8</td><td>2</td><td>13</td><td>23</td><td>0</td><td>3</td><td>16</td><td>12</td><td>122</td><td>18</td><td>1</td><td>32</td><td>7</td><td>0</td><td>7</td><td>62</td><td>13</td><td>7</td><td>1</td><td>13</td><td>7</td><td>6</td><td>49</td><td>306</td><td>12</td><td>8</td><td>11</td><td>0</td><td>0</td><td>0</td><td>69</td><td>5</td><td>0</td><td>44</td><td>1</td><td>1</td><td>4</td><td>0</td><td>87</td><td>10</td><td>51</td><td>71</td><td>41</td><td>7</td><td>121</td><td>4</td><td>55</td><td>36</td><td>101</td><td>69</td><td>30</td><td>23</td><td>6</td><td>27</td><td>12</td><td>18</td><td>20</td><td>4</td></tr>
	<tr><th scope=row>10</th><td>italian</td><td>919</td><td>12</td><td>266</td><td>168</td><td>34</td><td>25</td><td>237</td><td>231</td><td>305</td><td>372</td><td>2005</td><td>274</td><td>482</td><td>1</td><td>583</td><td>725</td><td>2473</td><td>82</td><td>406</td><td>880</td><td>550</td><td>192</td><td>1009</td><td>139</td><td>1660</td><td>48</td><td>48</td><td>45</td><td>311</td><td>9</td><td>434</td><td>65</td><td>428</td><td>116</td><td>5843</td><td>224</td><td>1835</td><td>41</td><td>41</td><td>107</td><td>3</td><td>28</td><td>6</td><td>128</td><td>210</td><td>1576</td><td>25</td><td>52</td><td>126</td><td>1965</td><td>156</td><td>23</td><td>64</td><td>51</td><td>95</td><td>819</td><td>20</td><td>218</td><td>78</td><td>117</td><td>994</td><td>399</td><td>133</td><td>878</td><td>40</td><td>37</td><td>9</td><td>37</td><td>513</td><td>107</td><td>24</td><td>223</td><td>130</td><td>2913</td><td>1793</td><td>228</td><td>0</td><td>1362</td><td>325</td><td>380</td><td>253</td><td>108</td><td>216</td><td>264</td><td>16</td><td>31</td><td>535</td><td>597</td><td>1361</td><td>247</td><td>4992</td><td>339</td><td>1</td><td>4173</td><td>42</td><td>70</td><td>114</td><td>2077</td><td>9</td><td>756</td><td>2981</td><td>237</td><td>97</td><td>377</td><td>0</td><td>131</td><td>249</td><td>56</td><td>1127</td><td>38</td><td>20</td><td>970</td><td>156</td><td>31</td><td>14</td><td>666</td><td>36</td><td>1291</td><td>729</td><td>163</td><td>1223</td><td>106</td><td>1401</td><td>177</td><td>74</td><td>82</td><td>50</td><td>326</td><td>189</td><td>1</td><td>63</td><td>77</td><td>92</td><td>2</td><td>737</td><td>388</td><td>169</td><td>0</td><td>97</td><td>22</td><td>1249</td><td>843</td><td>147</td><td>314</td><td>237</td><td>5183</td><td>4987</td><td>2717</td><td>289</td><td>987</td><td>9</td><td>89</td><td>2456</td><td>1746</td><td>450</td><td>1015</td><td>207</td><td>5</td><td>43</td><td>267</td><td>5668</td><td>38</td><td>34</td><td>380</td><td>231</td><td>286</td><td>723</td><td>351</td><td>85</td><td>2053</td><td>123</td><td>171</td><td>367</td><td>665</td><td>234</td><td>6</td><td>508</td><td>37</td><td>277</td><td>13</td><td>4897</td><td>1341</td><td>588</td><td>63</td><td>340</td><td>558</td><td>179</td><td>7</td><td>17</td><td>316</td><td>38</td><td>128</td><td>78</td><td>66</td><td>25</td><td>591</td><td>248</td><td>347</td><td>439</td><td>64</td><td>72</td><td>415</td><td>80</td><td>112</td><td>23</td><td>357</td><td>574</td><td>647</td><td>163</td><td>5</td><td>146</td><td>86</td><td>97</td><td>30</td><td>270</td><td>1378</td><td>199</td><td>16</td><td>35</td><td>0</td><td>2</td><td>65</td><td>524</td><td>63</td><td>17</td><td>3346</td><td>17</td><td>6</td><td>186</td><td>2</td><td>580</td><td>93</td><td>326</td><td>541</td><td>774</td><td>183</td><td>1483</td><td>63</td><td>173</td><td>279</td><td>1710</td><td>451</td><td>1521</td><td>60</td><td>248</td><td>366</td><td>34</td><td>226</td><td>272</td><td>340</td></tr>
	<tr><th scope=row>11</th><td>jamaican</td><td>42</td><td>195</td><td>3</td><td>6</td><td>8</td><td>6</td><td>7</td><td>10</td><td>49</td><td>1</td><td>8</td><td>21</td><td>60</td><td>0</td><td>59</td><td>74</td><td>222</td><td>6</td><td>35</td><td>35</td><td>41</td><td>1</td><td>29</td><td>109</td><td>92</td><td>2</td><td>10</td><td>10</td><td>1</td><td>2</td><td>49</td><td>50</td><td>16</td><td>2</td><td>17</td><td>4</td><td>178</td><td>0</td><td>59</td><td>57</td><td>5</td><td>4</td><td>3</td><td>7</td><td>4</td><td>70</td><td>17</td><td>34</td><td>127</td><td>145</td><td>6</td><td>140</td><td>32</td><td>10</td><td>1</td><td>46</td><td>20</td><td>24</td><td>13</td><td>5</td><td>24</td><td>31</td><td>0</td><td>16</td><td>1</td><td>30</td><td>76</td><td>44</td><td>16</td><td>6</td><td>2</td><td>7</td><td>1</td><td>163</td><td>65</td><td>1</td><td>0</td><td>6</td><td>23</td><td>11</td><td>0</td><td>0</td><td>11</td><td>11</td><td>0</td><td>13</td><td>34</td><td>3</td><td>111</td><td>5</td><td>226</td><td>6</td><td>2</td><td>313</td><td>124</td><td>1</td><td>12</td><td>32</td><td>1</td><td>109</td><td>542</td><td>13</td><td>5</td><td>2</td><td>0</td><td>8</td><td>63</td><td>10</td><td>1</td><td>0</td><td>30</td><td>136</td><td>0</td><td>1</td><td>33</td><td>33</td><td>1</td><td>24</td><td>9</td><td>9</td><td>59</td><td>1</td><td>23</td><td>1</td><td>6</td><td>26</td><td>153</td><td>17</td><td>2</td><td>3</td><td>9</td><td>17</td><td>4</td><td>0</td><td>146</td><td>31</td><td>2</td><td>0</td><td>9</td><td>0</td><td>4</td><td>5</td><td>17</td><td>3</td><td>120</td><td>270</td><td>73</td><td>374</td><td>47</td><td>7</td><td>1</td><td>28</td><td>2</td><td>15</td><td>16</td><td>1</td><td>19</td><td>8</td><td>8</td><td>14</td><td>616</td><td>10</td><td>11</td><td>5</td><td>32</td><td>53</td><td>202</td><td>26</td><td>11</td><td>123</td><td>2</td><td>3</td><td>67</td><td>0</td><td>9</td><td>16</td><td>6</td><td>0</td><td>8</td><td>2</td><td>419</td><td>173</td><td>0</td><td>113</td><td>21</td><td>52</td><td>19</td><td>5</td><td>2</td><td>9</td><td>0</td><td>1</td><td>4</td><td>0</td><td>1</td><td>7</td><td>20</td><td>32</td><td>15</td><td>6</td><td>14</td><td>17</td><td>2</td><td>9</td><td>81</td><td>0</td><td>14</td><td>16</td><td>11</td><td>8</td><td>6</td><td>11</td><td>9</td><td>7</td><td>38</td><td>204</td><td>27</td><td>12</td><td>8</td><td>0</td><td>0</td><td>17</td><td>296</td><td>3</td><td>0</td><td>85</td><td>5</td><td>15</td><td>3</td><td>13</td><td>19</td><td>16</td><td>37</td><td>121</td><td>90</td><td>5</td><td>210</td><td>5</td><td>2</td><td>3</td><td>91</td><td>10</td><td>24</td><td>10</td><td>12</td><td>35</td><td>2</td><td>2</td><td>7</td><td>5</td></tr>
	<tr><th scope=row>12</th><td>japanese</td><td>69</td><td>1</td><td>13</td><td>5</td><td>18</td><td>60</td><td>38</td><td>8</td><td>55</td><td>4</td><td>10</td><td>24</td><td>51</td><td>22</td><td>71</td><td>51</td><td>154</td><td>19</td><td>91</td><td>14</td><td>65</td><td>17</td><td>67</td><td>115</td><td>105</td><td>0</td><td>105</td><td>63</td><td>0</td><td>38</td><td>204</td><td>26</td><td>19</td><td>1</td><td>35</td><td>9</td><td>276</td><td>3</td><td>28</td><td>182</td><td>17</td><td>1</td><td>1</td><td>37</td><td>8</td><td>74</td><td>8</td><td>93</td><td>23</td><td>116</td><td>9</td><td>43</td><td>32</td><td>8</td><td>4</td><td>72</td><td>65</td><td>114</td><td>0</td><td>7</td><td>61</td><td>4</td><td>0</td><td>22</td><td>116</td><td>65</td><td>36</td><td>54</td><td>6</td><td>13</td><td>5</td><td>6</td><td>7</td><td>128</td><td>334</td><td>39</td><td>0</td><td>22</td><td>23</td><td>12</td><td>12</td><td>0</td><td>103</td><td>21</td><td>68</td><td>27</td><td>120</td><td>6</td><td>203</td><td>15</td><td>404</td><td>44</td><td>46</td><td>358</td><td>461</td><td>3</td><td>48</td><td>19</td><td>1</td><td>330</td><td>261</td><td>8</td><td>4</td><td>15</td><td>9</td><td>79</td><td>40</td><td>14</td><td>2</td><td>1</td><td>5</td><td>143</td><td>0</td><td>5</td><td>37</td><td>81</td><td>0</td><td>124</td><td>18</td><td>2</td><td>111</td><td>19</td><td>140</td><td>3</td><td>11</td><td>48</td><td>64</td><td>79</td><td>1</td><td>51</td><td>51</td><td>28</td><td>19</td><td>0</td><td>102</td><td>49</td><td>5</td><td>402</td><td>15</td><td>0</td><td>4</td><td>147</td><td>48</td><td>136</td><td>3</td><td>901</td><td>81</td><td>472</td><td>36</td><td>0</td><td>13</td><td>9</td><td>8</td><td>11</td><td>184</td><td>3</td><td>75</td><td>32</td><td>4</td><td>58</td><td>390</td><td>10</td><td>16</td><td>8</td><td>112</td><td>96</td><td>236</td><td>14</td><td>4</td><td>179</td><td>34</td><td>13</td><td>554</td><td>1</td><td>17</td><td>51</td><td>0</td><td>7</td><td>0</td><td>0</td><td>581</td><td>940</td><td>2</td><td>236</td><td>75</td><td>24</td><td>346</td><td>2</td><td>520</td><td>30</td><td>1</td><td>8</td><td>15</td><td>138</td><td>9</td><td>28</td><td>71</td><td>65</td><td>41</td><td>22</td><td>20</td><td>114</td><td>12</td><td>3</td><td>779</td><td>2</td><td>73</td><td>27</td><td>4</td><td>42</td><td>10</td><td>111</td><td>50</td><td>10</td><td>64</td><td>650</td><td>41</td><td>10</td><td>10</td><td>0</td><td>7</td><td>65</td><td>3</td><td>137</td><td>127</td><td>78</td><td>1</td><td>29</td><td>3</td><td>34</td><td>21</td><td>0</td><td>20</td><td>292</td><td>337</td><td>11</td><td>479</td><td>20</td><td>16</td><td>2</td><td>300</td><td>25</td><td>65</td><td>22</td><td>7</td><td>48</td><td>4</td><td>49</td><td>14</td><td>18</td></tr>
	<tr><th scope=row>13</th><td>korean</td><td>31</td><td>0</td><td>1</td><td>0</td><td>27</td><td>2</td><td>22</td><td>8</td><td>10</td><td>4</td><td>2</td><td>3</td><td>64</td><td>32</td><td>166</td><td>31</td><td>192</td><td>4</td><td>26</td><td>3</td><td>10</td><td>4</td><td>37</td><td>168</td><td>15</td><td>2</td><td>110</td><td>46</td><td>0</td><td>0</td><td>180</td><td>16</td><td>5</td><td>6</td><td>13</td><td>0</td><td>109</td><td>1</td><td>77</td><td>162</td><td>20</td><td>2</td><td>0</td><td>21</td><td>0</td><td>45</td><td>12</td><td>17</td><td>6</td><td>181</td><td>16</td><td>8</td><td>20</td><td>0</td><td>0</td><td>73</td><td>6</td><td>66</td><td>0</td><td>3</td><td>6</td><td>1</td><td>0</td><td>47</td><td>81</td><td>1</td><td>2</td><td>69</td><td>1</td><td>3</td><td>0</td><td>1</td><td>3</td><td>45</td><td>170</td><td>4</td><td>0</td><td>4</td><td>6</td><td>4</td><td>0</td><td>0</td><td>8</td><td>2</td><td>35</td><td>59</td><td>149</td><td>4</td><td>88</td><td>4</td><td>186</td><td>3</td><td>0</td><td>639</td><td>320</td><td>4</td><td>24</td><td>1</td><td>1</td><td>348</td><td>191</td><td>1</td><td>3</td><td>3</td><td>4</td><td>80</td><td>40</td><td>7</td><td>0</td><td>1</td><td>16</td><td>63</td><td>0</td><td>1</td><td>13</td><td>74</td><td>6</td><td>52</td><td>10</td><td>11</td><td>39</td><td>9</td><td>20</td><td>2</td><td>46</td><td>36</td><td>11</td><td>50</td><td>0</td><td>0</td><td>9</td><td>17</td><td>10</td><td>0</td><td>6</td><td>112</td><td>0</td><td>59</td><td>7</td><td>0</td><td>1</td><td>89</td><td>13</td><td>56</td><td>0</td><td>815</td><td>42</td><td>625</td><td>8</td><td>0</td><td>20</td><td>11</td><td>0</td><td>3</td><td>96</td><td>2</td><td>9</td><td>19</td><td>0</td><td>21</td><td>578</td><td>2</td><td>4</td><td>2</td><td>90</td><td>52</td><td>64</td><td>8</td><td>2</td><td>237</td><td>22</td><td>91</td><td>414</td><td>0</td><td>24</td><td>16</td><td>1</td><td>0</td><td>0</td><td>1</td><td>382</td><td>676</td><td>4</td><td>197</td><td>36</td><td>10</td><td>368</td><td>4</td><td>897</td><td>7</td><td>1</td><td>1</td><td>12</td><td>77</td><td>9</td><td>20</td><td>31</td><td>11</td><td>24</td><td>3</td><td>9</td><td>84</td><td>0</td><td>3</td><td>544</td><td>1</td><td>65</td><td>15</td><td>0</td><td>46</td><td>4</td><td>47</td><td>85</td><td>4</td><td>33</td><td>488</td><td>44</td><td>0</td><td>46</td><td>0</td><td>5</td><td>13</td><td>1</td><td>191</td><td>67</td><td>7</td><td>10</td><td>0</td><td>5</td><td>0</td><td>4</td><td>0</td><td>4</td><td>135</td><td>216</td><td>4</td><td>278</td><td>0</td><td>5</td><td>0</td><td>148</td><td>5</td><td>84</td><td>1</td><td>2</td><td>40</td><td>1</td><td>10</td><td>3</td><td>54</td></tr>
	<tr><th scope=row>14</th><td>mexican</td><td>330</td><td>66</td><td>83</td><td>86</td><td>92</td><td>1103</td><td>43</td><td>126</td><td>256</td><td>24</td><td>63</td><td>188</td><td>1710</td><td>0</td><td>839</td><td>928</td><td>2245</td><td>40</td><td>608</td><td>109</td><td>853</td><td>16</td><td>858</td><td>263</td><td>577</td><td>30</td><td>192</td><td>267</td><td>27</td><td>2</td><td>169</td><td>425</td><td>111</td><td>1135</td><td>2976</td><td>91</td><td>2473</td><td>16</td><td>1490</td><td>3039</td><td>0</td><td>444</td><td>505</td><td>24</td><td>129</td><td>2077</td><td>144</td><td>2794</td><td>319</td><td>1168</td><td>169</td><td>54</td><td>37</td><td>138</td><td>20</td><td>719</td><td>218</td><td>2152</td><td>42</td><td>49</td><td>1910</td><td>46</td><td>39</td><td>155</td><td>68</td><td>2061</td><td>6</td><td>47</td><td>806</td><td>19</td><td>16</td><td>48</td><td>124</td><td>835</td><td>654</td><td>4</td><td>400</td><td>206</td><td>104</td><td>292</td><td>6</td><td>42</td><td>115</td><td>144</td><td>18</td><td>24</td><td>134</td><td>26</td><td>1425</td><td>121</td><td>2684</td><td>356</td><td>0</td><td>3222</td><td>32</td><td>20</td><td>77</td><td>164</td><td>66</td><td>1946</td><td>3495</td><td>180</td><td>27</td><td>71</td><td>1</td><td>120</td><td>346</td><td>82</td><td>41</td><td>854</td><td>1175</td><td>1628</td><td>4</td><td>420</td><td>37</td><td>617</td><td>11</td><td>399</td><td>113</td><td>212</td><td>579</td><td>3</td><td>237</td><td>75</td><td>509</td><td>118</td><td>2286</td><td>195</td><td>111</td><td>0</td><td>166</td><td>124</td><td>58</td><td>500</td><td>449</td><td>274</td><td>50</td><td>1</td><td>343</td><td>530</td><td>95</td><td>151</td><td>50</td><td>24</td><td>15</td><td>2978</td><td>1846</td><td>4436</td><td>283</td><td>906</td><td>4</td><td>363</td><td>51</td><td>147</td><td>181</td><td>79</td><td>32</td><td>46</td><td>27</td><td>66</td><td>4689</td><td>55</td><td>71</td><td>190</td><td>396</td><td>230</td><td>2376</td><td>618</td><td>73</td><td>1175</td><td>189</td><td>48</td><td>520</td><td>16</td><td>247</td><td>4</td><td>16</td><td>7</td><td>7</td><td>1283</td><td>3920</td><td>1508</td><td>96</td><td>172</td><td>199</td><td>670</td><td>284</td><td>236</td><td>60</td><td>46</td><td>167</td><td>123</td><td>18</td><td>11</td><td>119</td><td>1456</td><td>178</td><td>487</td><td>328</td><td>168</td><td>38</td><td>293</td><td>206</td><td>1323</td><td>61</td><td>17</td><td>109</td><td>361</td><td>112</td><td>15</td><td>65</td><td>59</td><td>170</td><td>70</td><td>248</td><td>690</td><td>226</td><td>51</td><td>21</td><td>637</td><td>0</td><td>93</td><td>68</td><td>24</td><td>13</td><td>2868</td><td>2535</td><td>5</td><td>181</td><td>10</td><td>160</td><td>67</td><td>150</td><td>997</td><td>435</td><td>56</td><td>1099</td><td>256</td><td>114</td><td>72</td><td>1009</td><td>357</td><td>160</td><td>67</td><td>33</td><td>446</td><td>115</td><td>44</td><td>69</td><td>147</td></tr>
	<tr><th scope=row>15</th><td>moroccan</td><td>44</td><td>44</td><td>111</td><td>6</td><td>7</td><td>2</td><td>12</td><td>0</td><td>11</td><td>5</td><td>9</td><td>23</td><td>58</td><td>0</td><td>68</td><td>77</td><td>278</td><td>18</td><td>56</td><td>20</td><td>65</td><td>4</td><td>180</td><td>23</td><td>110</td><td>0</td><td>4</td><td>20</td><td>8</td><td>29</td><td>167</td><td>142</td><td>36</td><td>2</td><td>24</td><td>12</td><td>365</td><td>132</td><td>23</td><td>43</td><td>0</td><td>2</td><td>0</td><td>2</td><td>0</td><td>335</td><td>4</td><td>286</td><td>413</td><td>299</td><td>23</td><td>7</td><td>1</td><td>1</td><td>9</td><td>49</td><td>252</td><td>9</td><td>3</td><td>8</td><td>6</td><td>7</td><td>7</td><td>36</td><td>8</td><td>452</td><td>23</td><td>1</td><td>65</td><td>3</td><td>6</td><td>7</td><td>1</td><td>182</td><td>74</td><td>35</td><td>0</td><td>128</td><td>3</td><td>40</td><td>25</td><td>12</td><td>27</td><td>25</td><td>1</td><td>6</td><td>34</td><td>66</td><td>90</td><td>28</td><td>676</td><td>9</td><td>6</td><td>450</td><td>287</td><td>50</td><td>9</td><td>46</td><td>20</td><td>142</td><td>1370</td><td>43</td><td>0</td><td>1</td><td>0</td><td>117</td><td>21</td><td>2</td><td>6</td><td>0</td><td>2</td><td>259</td><td>23</td><td>0</td><td>2</td><td>95</td><td>170</td><td>63</td><td>79</td><td>3</td><td>96</td><td>4</td><td>449</td><td>29</td><td>5</td><td>4</td><td>20</td><td>41</td><td>5</td><td>6</td><td>7</td><td>14</td><td>2</td><td>0</td><td>20</td><td>34</td><td>118</td><td>0</td><td>8</td><td>0</td><td>1</td><td>6</td><td>9</td><td>5</td><td>32</td><td>638</td><td>658</td><td>496</td><td>89</td><td>12</td><td>1</td><td>243</td><td>3</td><td>242</td><td>80</td><td>5</td><td>15</td><td>4</td><td>0</td><td>41</td><td>685</td><td>8</td><td>17</td><td>23</td><td>6</td><td>78</td><td>77</td><td>67</td><td>97</td><td>186</td><td>7</td><td>17</td><td>19</td><td>2</td><td>18</td><td>8</td><td>6</td><td>126</td><td>0</td><td>1</td><td>601</td><td>25</td><td>11</td><td>5</td><td>42</td><td>6</td><td>140</td><td>2</td><td>20</td><td>30</td><td>0</td><td>5</td><td>10</td><td>0</td><td>33</td><td>1</td><td>8</td><td>51</td><td>32</td><td>31</td><td>0</td><td>59</td><td>1</td><td>4</td><td>4</td><td>2</td><td>12</td><td>43</td><td>29</td><td>2</td><td>44</td><td>0</td><td>13</td><td>72</td><td>103</td><td>130</td><td>104</td><td>0</td><td>3</td><td>0</td><td>0</td><td>52</td><td>22</td><td>14</td><td>1</td><td>308</td><td>0</td><td>112</td><td>8</td><td>73</td><td>47</td><td>1</td><td>6</td><td>118</td><td>41</td><td>20</td><td>253</td><td>17</td><td>12</td><td>2</td><td>66</td><td>28</td><td>51</td><td>0</td><td>20</td><td>66</td><td>34</td><td>8</td><td>32</td><td>40</td></tr>
	<tr><th scope=row>16</th><td>russian</td><td>123</td><td>8</td><td>26</td><td>4</td><td>31</td><td>2</td><td>0</td><td>11</td><td>74</td><td>4</td><td>6</td><td>39</td><td>18</td><td>0</td><td>72</td><td>18</td><td>106</td><td>14</td><td>7</td><td>41</td><td>13</td><td>0</td><td>42</td><td>15</td><td>213</td><td>12</td><td>70</td><td>9</td><td>10</td><td>6</td><td>80</td><td>9</td><td>40</td><td>4</td><td>68</td><td>9</td><td>43</td><td>1</td><td>2</td><td>9</td><td>0</td><td>1</td><td>0</td><td>14</td><td>17</td><td>59</td><td>14</td><td>9</td><td>34</td><td>69</td><td>11</td><td>1</td><td>19</td><td>10</td><td>13</td><td>15</td><td>6</td><td>16</td><td>1</td><td>4</td><td>183</td><td>24</td><td>0</td><td>1</td><td>20</td><td>5</td><td>0</td><td>10</td><td>11</td><td>9</td><td>111</td><td>4</td><td>2</td><td>91</td><td>280</td><td>2</td><td>0</td><td>6</td><td>44</td><td>4</td><td>6</td><td>2</td><td>17</td><td>13</td><td>0</td><td>4</td><td>6</td><td>11</td><td>237</td><td>0</td><td>160</td><td>10</td><td>0</td><td>88</td><td>9</td><td>16</td><td>19</td><td>10</td><td>2</td><td>51</td><td>159</td><td>6</td><td>13</td><td>18</td><td>0</td><td>22</td><td>17</td><td>4</td><td>2</td><td>0</td><td>2</td><td>64</td><td>1</td><td>0</td><td>9</td><td>23</td><td>3</td><td>121</td><td>23</td><td>8</td><td>39</td><td>9</td><td>101</td><td>0</td><td>2</td><td>8</td><td>0</td><td>4</td><td>7</td><td>2</td><td>31</td><td>11</td><td>2</td><td>0</td><td>98</td><td>10</td><td>4</td><td>0</td><td>5</td><td>0</td><td>4</td><td>47</td><td>17</td><td>8</td><td>8</td><td>173</td><td>66</td><td>209</td><td>14</td><td>2</td><td>0</td><td>20</td><td>2</td><td>59</td><td>19</td><td>1</td><td>20</td><td>0</td><td>0</td><td>14</td><td>213</td><td>12</td><td>15</td><td>4</td><td>26</td><td>128</td><td>82</td><td>8</td><td>40</td><td>57</td><td>5</td><td>16</td><td>20</td><td>3</td><td>4</td><td>9</td><td>3</td><td>4</td><td>1</td><td>0</td><td>345</td><td>32</td><td>10</td><td>9</td><td>14</td><td>7</td><td>43</td><td>0</td><td>0</td><td>9</td><td>1</td><td>0</td><td>2</td><td>2</td><td>2</td><td>9</td><td>4</td><td>7</td><td>15</td><td>15</td><td>24</td><td>8</td><td>7</td><td>127</td><td>3</td><td>0</td><td>4</td><td>6</td><td>2</td><td>0</td><td>0</td><td>14</td><td>9</td><td>8</td><td>20</td><td>251</td><td>18</td><td>3</td><td>6</td><td>0</td><td>0</td><td>1</td><td>11</td><td>5</td><td>2</td><td>82</td><td>1</td><td>1</td><td>6</td><td>0</td><td>94</td><td>7</td><td>63</td><td>91</td><td>74</td><td>22</td><td>167</td><td>2</td><td>8</td><td>18</td><td>95</td><td>28</td><td>38</td><td>6</td><td>57</td><td>9</td><td>13</td><td>36</td><td>10</td><td>2</td></tr>
	<tr><th scope=row>17</th><td>southern_us</td><td>1223</td><td>59</td><td>70</td><td>61</td><td>232</td><td>13</td><td>48</td><td>431</td><td>1240</td><td>31</td><td>82</td><td>192</td><td>157</td><td>0</td><td>86</td><td>303</td><td>866</td><td>65</td><td>130</td><td>258</td><td>145</td><td>13</td><td>390</td><td>627</td><td>2136</td><td>712</td><td>64</td><td>115</td><td>8</td><td>9</td><td>151</td><td>331</td><td>350</td><td>403</td><td>872</td><td>48</td><td>922</td><td>2</td><td>68</td><td>219</td><td>0</td><td>30</td><td>23</td><td>92</td><td>112</td><td>751</td><td>228</td><td>58</td><td>399</td><td>396</td><td>73</td><td>121</td><td>67</td><td>115</td><td>65</td><td>311</td><td>16</td><td>829</td><td>318</td><td>58</td><td>965</td><td>168</td><td>16</td><td>154</td><td>25</td><td>75</td><td>28</td><td>169</td><td>137</td><td>101</td><td>44</td><td>21</td><td>65</td><td>501</td><td>1688</td><td>3</td><td>1</td><td>98</td><td>591</td><td>119</td><td>13</td><td>4</td><td>73</td><td>98</td><td>77</td><td>7</td><td>166</td><td>47</td><td>1847</td><td>71</td><td>1026</td><td>168</td><td>2</td><td>987</td><td>116</td><td>41</td><td>289</td><td>231</td><td>14</td><td>789</td><td>1532</td><td>128</td><td>223</td><td>255</td><td>2</td><td>176</td><td>332</td><td>152</td><td>52</td><td>46</td><td>110</td><td>594</td><td>3</td><td>117</td><td>102</td><td>357</td><td>3</td><td>934</td><td>114</td><td>14</td><td>216</td><td>18</td><td>586</td><td>29</td><td>55</td><td>309</td><td>169</td><td>80</td><td>77</td><td>2</td><td>182</td><td>56</td><td>33</td><td>5</td><td>1117</td><td>106</td><td>109</td><td>0</td><td>164</td><td>19</td><td>13</td><td>77</td><td>336</td><td>5</td><td>221</td><td>1276</td><td>429</td><td>1365</td><td>205</td><td>55</td><td>28</td><td>270</td><td>136</td><td>286</td><td>36</td><td>18</td><td>210</td><td>175</td><td>429</td><td>37</td><td>2709</td><td>27</td><td>30</td><td>29</td><td>221</td><td>314</td><td>1414</td><td>95</td><td>48</td><td>559</td><td>57</td><td>134</td><td>154</td><td>1</td><td>87</td><td>7</td><td>54</td><td>1</td><td>79</td><td>18</td><td>3088</td><td>798</td><td>153</td><td>71</td><td>106</td><td>365</td><td>112</td><td>4</td><td>14</td><td>64</td><td>212</td><td>51</td><td>25</td><td>10</td><td>35</td><td>221</td><td>217</td><td>98</td><td>226</td><td>155</td><td>473</td><td>101</td><td>89</td><td>137</td><td>35</td><td>2</td><td>21</td><td>206</td><td>75</td><td>1</td><td>36</td><td>159</td><td>64</td><td>28</td><td>118</td><td>2319</td><td>316</td><td>125</td><td>271</td><td>2</td><td>0</td><td>49</td><td>259</td><td>29</td><td>0</td><td>469</td><td>9</td><td>9</td><td>49</td><td>12</td><td>660</td><td>69</td><td>778</td><td>658</td><td>459</td><td>31</td><td>895</td><td>27</td><td>47</td><td>243</td><td>837</td><td>328</td><td>161</td><td>182</td><td>40</td><td>377</td><td>37</td><td>146</td><td>102</td><td>14</td></tr>
	<tr><th scope=row>18</th><td>spanish</td><td>53</td><td>4</td><td>94</td><td>5</td><td>24</td><td>23</td><td>16</td><td>24</td><td>33</td><td>24</td><td>35</td><td>93</td><td>64</td><td>0</td><td>36</td><td>265</td><td>251</td><td>19</td><td>33</td><td>117</td><td>42</td><td>2</td><td>133</td><td>22</td><td>92</td><td>3</td><td>9</td><td>7</td><td>20</td><td>1</td><td>45</td><td>40</td><td>24</td><td>7</td><td>88</td><td>14</td><td>262</td><td>23</td><td>48</td><td>68</td><td>0</td><td>5</td><td>6</td><td>16</td><td>6</td><td>224</td><td>8</td><td>86</td><td>68</td><td>381</td><td>16</td><td>4</td><td>5</td><td>16</td><td>5</td><td>66</td><td>11</td><td>41</td><td>4</td><td>8</td><td>68</td><td>35</td><td>5</td><td>56</td><td>78</td><td>70</td><td>5</td><td>8</td><td>74</td><td>12</td><td>5</td><td>6</td><td>1</td><td>275</td><td>274</td><td>13</td><td>0</td><td>255</td><td>35</td><td>40</td><td>17</td><td>4</td><td>32</td><td>23</td><td>1</td><td>16</td><td>44</td><td>82</td><td>98</td><td>32</td><td>487</td><td>46</td><td>0</td><td>561</td><td>11</td><td>13</td><td>10</td><td>39</td><td>1</td><td>258</td><td>361</td><td>21</td><td>53</td><td>18</td><td>0</td><td>25</td><td>60</td><td>26</td><td>18</td><td>1</td><td>31</td><td>243</td><td>8</td><td>9</td><td>6</td><td>122</td><td>7</td><td>251</td><td>130</td><td>4</td><td>104</td><td>11</td><td>214</td><td>25</td><td>13</td><td>8</td><td>67</td><td>37</td><td>17</td><td>0</td><td>15</td><td>12</td><td>32</td><td>1</td><td>107</td><td>62</td><td>25</td><td>0</td><td>11</td><td>1</td><td>2</td><td>24</td><td>16</td><td>2</td><td>16</td><td>734</td><td>729</td><td>516</td><td>141</td><td>67</td><td>4</td><td>196</td><td>12</td><td>245</td><td>42</td><td>6</td><td>72</td><td>0</td><td>3</td><td>30</td><td>910</td><td>8</td><td>10</td><td>52</td><td>44</td><td>166</td><td>53</td><td>55</td><td>28</td><td>407</td><td>10</td><td>14</td><td>135</td><td>2</td><td>58</td><td>0</td><td>23</td><td>126</td><td>5</td><td>13</td><td>677</td><td>77</td><td>89</td><td>24</td><td>52</td><td>9</td><td>18</td><td>33</td><td>1</td><td>29</td><td>1</td><td>5</td><td>127</td><td>3</td><td>5</td><td>2</td><td>121</td><td>31</td><td>55</td><td>75</td><td>18</td><td>56</td><td>2</td><td>19</td><td>4</td><td>5</td><td>19</td><td>49</td><td>27</td><td>0</td><td>3</td><td>17</td><td>6</td><td>34</td><td>58</td><td>188</td><td>60</td><td>16</td><td>7</td><td>0</td><td>0</td><td>31</td><td>73</td><td>4</td><td>0</td><td>436</td><td>8</td><td>9</td><td>18</td><td>3</td><td>44</td><td>3</td><td>47</td><td>81</td><td>214</td><td>8</td><td>206</td><td>29</td><td>4</td><td>17</td><td>247</td><td>34</td><td>270</td><td>14</td><td>12</td><td>64</td><td>11</td><td>41</td><td>33</td><td>19</td></tr>
	<tr><th scope=row>19</th><td>thai</td><td>17</td><td>1</td><td>8</td><td>7</td><td>18</td><td>14</td><td>56</td><td>1</td><td>8</td><td>4</td><td>334</td><td>14</td><td>136</td><td>152</td><td>54</td><td>255</td><td>127</td><td>13</td><td>231</td><td>16</td><td>313</td><td>40</td><td>204</td><td>339</td><td>228</td><td>1</td><td>91</td><td>77</td><td>0</td><td>21</td><td>225</td><td>53</td><td>21</td><td>0</td><td>12</td><td>34</td><td>762</td><td>8</td><td>285</td><td>556</td><td>35</td><td>1</td><td>0</td><td>23</td><td>0</td><td>355</td><td>15</td><td>730</td><td>23</td><td>357</td><td>11</td><td>743</td><td>14</td><td>9</td><td>0</td><td>178</td><td>189</td><td>110</td><td>0</td><td>6</td><td>44</td><td>9</td><td>1</td><td>106</td><td>125</td><td>88</td><td>480</td><td>86</td><td>12</td><td>2</td><td>0</td><td>2</td><td>11</td><td>149</td><td>209</td><td>36</td><td>0</td><td>9</td><td>6</td><td>53</td><td>4</td><td>1</td><td>55</td><td>7</td><td>89</td><td>832</td><td>137</td><td>1</td><td>54</td><td>24</td><td>1325</td><td>28</td><td>2</td><td>957</td><td>521</td><td>10</td><td>30</td><td>33</td><td>2</td><td>575</td><td>389</td><td>55</td><td>0</td><td>8</td><td>17</td><td>80</td><td>66</td><td>10</td><td>2</td><td>1</td><td>84</td><td>590</td><td>0</td><td>4</td><td>30</td><td>84</td><td>3</td><td>147</td><td>18</td><td>11</td><td>527</td><td>7</td><td>151</td><td>21</td><td>77</td><td>184</td><td>1114</td><td>106</td><td>8</td><td>3</td><td>10</td><td>14</td><td>68</td><td>0</td><td>632</td><td>122</td><td>171</td><td>7</td><td>11</td><td>1</td><td>4</td><td>135</td><td>14</td><td>258</td><td>10</td><td>1057</td><td>125</td><td>699</td><td>38</td><td>4</td><td>46</td><td>19</td><td>2</td><td>8</td><td>570</td><td>5</td><td>89</td><td>625</td><td>0</td><td>111</td><td>962</td><td>38</td><td>5</td><td>11</td><td>83</td><td>49</td><td>175</td><td>84</td><td>6</td><td>831</td><td>58</td><td>17</td><td>653</td><td>0</td><td>183</td><td>82</td><td>0</td><td>2</td><td>1</td><td>2</td><td>585</td><td>1636</td><td>0</td><td>138</td><td>47</td><td>19</td><td>136</td><td>50</td><td>247</td><td>244</td><td>0</td><td>7</td><td>8</td><td>40</td><td>4</td><td>55</td><td>293</td><td>220</td><td>100</td><td>2</td><td>3</td><td>169</td><td>4</td><td>0</td><td>506</td><td>9</td><td>37</td><td>46</td><td>33</td><td>59</td><td>32</td><td>75</td><td>73</td><td>48</td><td>119</td><td>865</td><td>128</td><td>12</td><td>22</td><td>0</td><td>487</td><td>62</td><td>4</td><td>54</td><td>106</td><td>148</td><td>15</td><td>39</td><td>18</td><td>41</td><td>55</td><td>121</td><td>3</td><td>414</td><td>233</td><td>9</td><td>381</td><td>114</td><td>12</td><td>3</td><td>202</td><td>13</td><td>49</td><td>4</td><td>2</td><td>68</td><td>7</td><td>1</td><td>55</td><td>46</td></tr>
	<tr><th scope=row>20</th><td>vietnamese</td><td>12</td><td>4</td><td>4</td><td>4</td><td>11</td><td>14</td><td>20</td><td>2</td><td>9</td><td>1</td><td>162</td><td>9</td><td>84</td><td>127</td><td>110</td><td>40</td><td>190</td><td>5</td><td>66</td><td>10</td><td>69</td><td>11</td><td>78</td><td>99</td><td>63</td><td>0</td><td>61</td><td>85</td><td>0</td><td>16</td><td>254</td><td>10</td><td>15</td><td>0</td><td>2</td><td>2</td><td>238</td><td>0</td><td>170</td><td>251</td><td>36</td><td>1</td><td>1</td><td>9</td><td>0</td><td>160</td><td>9</td><td>336</td><td>54</td><td>207</td><td>9</td><td>62</td><td>13</td><td>18</td><td>1</td><td>71</td><td>83</td><td>60</td><td>0</td><td>13</td><td>7</td><td>2</td><td>0</td><td>34</td><td>158</td><td>9</td><td>30</td><td>35</td><td>8</td><td>1</td><td>6</td><td>1</td><td>5</td><td>69</td><td>94</td><td>6</td><td>0</td><td>5</td><td>4</td><td>14</td><td>10</td><td>0</td><td>19</td><td>7</td><td>38</td><td>490</td><td>41</td><td>1</td><td>59</td><td>5</td><td>563</td><td>7</td><td>0</td><td>542</td><td>228</td><td>4</td><td>24</td><td>16</td><td>1</td><td>210</td><td>271</td><td>7</td><td>5</td><td>2</td><td>63</td><td>33</td><td>58</td><td>10</td><td>3</td><td>1</td><td>61</td><td>257</td><td>0</td><td>2</td><td>6</td><td>92</td><td>2</td><td>47</td><td>22</td><td>3</td><td>284</td><td>4</td><td>60</td><td>6</td><td>120</td><td>39</td><td>373</td><td>32</td><td>2</td><td>0</td><td>33</td><td>32</td><td>45</td><td>0</td><td>64</td><td>86</td><td>180</td><td>6</td><td>8</td><td>1</td><td>0</td><td>48</td><td>3</td><td>177</td><td>2</td><td>528</td><td>43</td><td>413</td><td>14</td><td>0</td><td>28</td><td>6</td><td>1</td><td>5</td><td>65</td><td>0</td><td>17</td><td>170</td><td>0</td><td>34</td><td>499</td><td>25</td><td>2</td><td>6</td><td>166</td><td>15</td><td>77</td><td>45</td><td>0</td><td>176</td><td>20</td><td>12</td><td>477</td><td>0</td><td>79</td><td>27</td><td>0</td><td>0</td><td>0</td><td>0</td><td>400</td><td>941</td><td>11</td><td>100</td><td>20</td><td>11</td><td>68</td><td>37</td><td>147</td><td>158</td><td>0</td><td>3</td><td>2</td><td>27</td><td>16</td><td>44</td><td>135</td><td>50</td><td>44</td><td>0</td><td>5</td><td>65</td><td>5</td><td>1</td><td>236</td><td>4</td><td>8</td><td>19</td><td>31</td><td>63</td><td>8</td><td>66</td><td>65</td><td>63</td><td>51</td><td>546</td><td>26</td><td>20</td><td>4</td><td>0</td><td>134</td><td>18</td><td>0</td><td>37</td><td>55</td><td>58</td><td>3</td><td>13</td><td>6</td><td>19</td><td>33</td><td>5</td><td>4</td><td>171</td><td>195</td><td>24</td><td>298</td><td>43</td><td>8</td><td>0</td><td>141</td><td>11</td><td>33</td><td>1</td><td>2</td><td>69</td><td>2</td><td>7</td><td>5</td><td>3</td></tr>
</tbody>
</table>





```R
aggregate(ingredientsDTM_train[,c(1:250)], list(ingredientsDTM_train[,251]), mean)
```




<table>
<thead><tr><th></th><th scope=col>Group.1</th><th scope=col>all-purpos</th><th scope=col>allspic</th><th scope=col>almond</th><th scope=col>and</th><th scope=col>appl</th><th scope=col>avocado</th><th scope=col>babi</th><th scope=col>bacon</th><th scope=col>bake</th><th scope=col>balsam</th><th scope=col>basil</th><th scope=col>bay</th><th scope=col>bean</th><th scope=col>beansprout</th><th scope=col>beef</th><th scope=col>bell</th><th scope=col>black</th><th scope=col>boil</th><th scope=col>boneless</th><th scope=col>bread</th><th scope=col>breast</th><th scope=col>broccoli</th><th scope=col>broth</th><th scope=col>brown</th><th scope=col>butter</th><th scope=col>buttermilk</th><th scope=col>cabbag</th><th scope=col>canola</th><th scope=col>caper</th><th scope=col>cardamom</th><th scope=col>carrot</th><th scope=col>cayenn</th><th scope=col>celeri</th><th scope=col>cheddar</th><th scope=col>chees</th><th scope=col>cherri</th><th scope=col>chicken</th><th scope=col>chickpea</th><th scope=col>chile</th><th scope=col>chili</th><th scope=col>chines</th><th scope=col>chip</th><th scope=col>chipotl</th><th scope=col>chive</th><th scope=col>chocol</th><th scope=col>chop</th><th scope=col>cider</th><th scope=col>cilantro</th><th scope=col>cinnamon</th><th scope=col>clove</th><th scope=col>coars</th><th scope=col>coconut</th><th scope=col>cold</th><th scope=col>condens</th><th scope=col>confection</th><th scope=col>cook</th><th scope=col>coriand</th><th scope=col>corn</th><th scope=col>cornmeal</th><th scope=col>crack</th><th scope=col>cream</th><th scope=col>crumb</th><th scope=col>crumbl</th><th scope=col>crush</th><th scope=col>cucumb</th><th scope=col>cumin</th><th scope=col>curri</th><th scope=col>dark</th><th scope=col>dice</th><th scope=col>dijon</th><th scope=col>dill</th><th scope=col>dough</th><th scope=col>dress</th><th scope=col>dri</th><th scope=col>egg</th><th scope=col>eggplant</th><th scope=col>enchilada</th><th scope=col>extra-virgin</th><th scope=col>extract</th><th scope=col>fat</th><th scope=col>fennel</th><th scope=col>feta</th><th scope=col>fillet</th><th scope=col>fine</th><th scope=col>firm</th><th scope=col>fish</th><th scope=col>flake</th><th scope=col>flat</th><th scope=col>flour</th><th scope=col>free</th><th scope=col>fresh</th><th scope=col>frozen</th><th scope=col>garam</th><th scope=col>garlic</th><th scope=col>ginger</th><th scope=col>golden</th><th scope=col>granul</th><th scope=col>grate</th><th scope=col>greek</th><th scope=col>green</th><th scope=col>ground</th><th scope=col>halv</th><th scope=col>ham</th><th scope=col>heavi</th><th scope=col>hoisin</th><th scope=col>honey</th><th scope=col>hot</th><th scope=col>ice</th><th scope=col>italian</th><th scope=col>jack</th><th scope=col>jalapeno</th><th scope=col>juic</th><th scope=col>kalamata</th><th scope=col>kernel</th><th scope=col>ketchup</th><th scope=col>kosher</th><th scope=col>lamb</th><th scope=col>larg</th><th scope=col>leaf</th><th scope=col>lean</th><th scope=col>leav</th><th scope=col>leek</th><th scope=col>lemon</th><th scope=col>less</th><th scope=col>lettuc</th><th scope=col>light</th><th scope=col>lime</th><th scope=col>low</th><th scope=col>low-fat</th><th scope=col>masala</th><th scope=col>mayonais</th><th scope=col>meat</th><th scope=col>medium</th><th scope=col>mexican</th><th scope=col>milk</th><th scope=col>minc</th><th scope=col>mint</th><th scope=col>mirin</th><th scope=col>mix</th><th scope=col>monterey</th><th scope=col>mozzarella</th><th scope=col>mushroom</th><th scope=col>mustard</th><th scope=col>noodl</th><th scope=col>nutmeg</th><th scope=col>oil</th><th scope=col>oliv</th><th scope=col>onion</th><th scope=col>orang</th><th scope=col>oregano</th><th scope=col>oyster</th><th scope=col>paprika</th><th scope=col>parmesan</th><th scope=col>parsley</th><th scope=col>past</th><th scope=col>pasta</th><th scope=col>pea</th><th scope=col>peanut</th><th scope=col>pecan</th><th scope=col>peel</th><th scope=col>pepper</th><th scope=col>peppercorn</th><th scope=col>plain</th><th scope=col>plum</th><th scope=col>pork</th><th scope=col>potato</th><th scope=col>powder</th><th scope=col>purpl</th><th scope=col>raisin</th><th scope=col>red</th><th scope=col>reduc</th><th scope=col>rib</th><th scope=col>rice</th><th scope=col>ricotta</th><th scope=col>roast</th><th scope=col>root</th><th scope=col>rosemari</th><th scope=col>saffron</th><th scope=col>sage</th><th scope=col>salsa</th><th scope=col>salt</th><th scope=col>sauc</th><th scope=col>sausag</th><th scope=col>scallion</th><th scope=col>sea</th><th scope=col>season</th><th scope=col>seed</th><th scope=col>serrano</th><th scope=col>sesam</th><th scope=col>shallot</th><th scope=col>sharp</th><th scope=col>shell</th><th scope=col>sherri</th><th scope=col>shiitak</th><th scope=col>shoulder</th><th scope=col>shred</th><th scope=col>shrimp</th><th scope=col>skinless</th><th scope=col>slice</th><th scope=col>smoke</th><th scope=col>soda</th><th scope=col>sodium</th><th scope=col>soup</th><th scope=col>sour</th><th scope=col>soy</th><th scope=col>spaghetti</th><th scope=col>spinach</th><th scope=col>spray</th><th scope=col>sprig</th><th scope=col>spring</th><th scope=col>squash</th><th scope=col>starch</th><th scope=col>steak</th><th scope=col>stick</th><th scope=col>stock</th><th scope=col>sugar</th><th scope=col>sweet</th><th scope=col>sweeten</th><th scope=col>syrup</th><th scope=col>taco</th><th scope=col>thai</th><th scope=col>thigh</th><th scope=col>thyme</th><th scope=col>toast</th><th scope=col>tofu</th><th scope=col>tomato</th><th scope=col>tortilla</th><th scope=col>tumer</th><th scope=col>turkey</th><th scope=col>turmer</th><th scope=col>unsalt</th><th scope=col>unsweeten</th><th scope=col>vanilla</th><th scope=col>veget</th><th scope=col>vinegar</th><th scope=col>warm</th><th scope=col>water</th><th scope=col>wedg</th><th scope=col>wheat</th><th scope=col>whip</th><th scope=col>white</th><th scope=col>whole</th><th scope=col>wine</th><th scope=col>worcestershir</th><th scope=col>yeast</th><th scope=col>yellow</th><th scope=col>yogurt</th><th scope=col>yolk</th><th scope=col>zest</th><th scope=col>zucchini</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>brazilian</td><td>0.0385439</td><td>0.002141328</td><td>0.05139186</td><td>0.004282655</td><td>0.02141328</td><td>0.02141328</td><td>0.006423983</td><td>0.06423983</td><td>0.04068522</td><td>0</td><td>0.004282655</td><td>0.1156317</td><td>0.1520343</td><td>0</td><td>0.06638116</td><td>0.1713062</td><td>0.2847966</td><td>0.00856531</td><td>0.03426124</td><td>0.02783726</td><td>0.03640257</td><td>0</td><td>0.07066381</td><td>0.04496788</td><td>0.1777302</td><td>0.004282655</td><td>0</td><td>0.02783726</td><td>0.002141328</td><td>0</td><td>0.05567452</td><td>0.04925054</td><td>0.01498929</td><td>0.01070664</td><td>0.1199143</td><td>0.01070664</td><td>0.1627409</td><td>0</td><td>0.04925054</td><td>0.08779443</td><td>0</td><td>0.00856531</td><td>0.01070664</td><td>0.004282655</td><td>0.07494647</td><td>0.1627409</td><td>0.004282655</td><td>0.1884368</td><td>0.02997859</td><td>0.1970021</td><td>0.01498929</td><td>0.3040685</td><td>0.02569593</td><td>0.1456103</td><td>0.002141328</td><td>0.05995717</td><td>0.04710921</td><td>0.07280514</td><td>0.00856531</td><td>0.006423983</td><td>0.07494647</td><td>0.01927195</td><td>0</td><td>0.06852248</td><td>0.004282655</td><td>0.0620985</td><td>0.004282655</td><td>0.01070664</td><td>0.04496788</td><td>0.00856531</td><td>0</td><td>0.002141328</td><td>0</td><td>0.1327623</td><td>0.2248394</td><td>0</td><td>0</td><td>0.02783726</td><td>0.0385439</td><td>0.01070664</td><td>0.006423983</td><td>0</td><td>0.05353319</td><td>0.01713062</td><td>0</td><td>0.05781585</td><td>0.07066381</td><td>0.02141328</td><td>0.1563169</td><td>0.01070664</td><td>0.2847966</td><td>0.06852248</td><td>0.002141328</td><td>0.4154176</td><td>0.06638116</td><td>0.002141328</td><td>0.04496788</td><td>0.04496788</td><td>0</td><td>0.1820128</td><td>0.2698073</td><td>0.006423983</td><td>0.03640257</td><td>0.01498929</td><td>0</td><td>0.02569593</td><td>0.04710921</td><td>0.1220557</td><td>0.01070664</td><td>0.006423983</td><td>0.04068522</td><td>0.2226981</td><td>0</td><td>0.00856531</td><td>0.002141328</td><td>0.04710921</td><td>0.004282655</td><td>0.07066381</td><td>0.07066381</td><td>0.002141328</td><td>0.1349036</td><td>0.004282655</td><td>0.07922912</td><td>0.006423983</td><td>0.002141328</td><td>0.03426124</td><td>0.3511777</td><td>0.02141328</td><td>0.01070664</td><td>0.002141328</td><td>0.02141328</td><td>0.006423983</td><td>0.02141328</td><td>0</td><td>0.490364</td><td>0.03211991</td><td>0.01498929</td><td>0</td><td>0.01284797</td><td>0.004282655</td><td>0.01070664</td><td>0.004282655</td><td>0.01070664</td><td>0</td><td>0.01070664</td><td>0.5289079</td><td>0.3104925</td><td>0.48394</td><td>0.1070664</td><td>0.02997859</td><td>0.002141328</td><td>0.04068522</td><td>0.05139186</td><td>0.117773</td><td>0.04496788</td><td>0.002141328</td><td>0.03426124</td><td>0.02141328</td><td>0.006423983</td><td>0.01284797</td><td>0.6638116</td><td>0.002141328</td><td>0.006423983</td><td>0.01927195</td><td>0.07494647</td><td>0.05567452</td><td>0.1349036</td><td>0.01713062</td><td>0.01284797</td><td>0.1841542</td><td>0.004282655</td><td>0.0385439</td><td>0.1349036</td><td>0</td><td>0.0235546</td><td>0.00856531</td><td>0.004282655</td><td>0.006423983</td><td>0.002141328</td><td>0.01498929</td><td>0.5267666</td><td>0.07494647</td><td>0.06423983</td><td>0.01713062</td><td>0.04068522</td><td>0.01498929</td><td>0.05567452</td><td>0.01498929</td><td>0.004282655</td><td>0.01070664</td><td>0.002141328</td><td>0.004282655</td><td>0.006423983</td><td>0</td><td>0.01927195</td><td>0.03211991</td><td>0.124197</td><td>0.02141328</td><td>0.04710921</td><td>0.03426124</td><td>0.01713062</td><td>0.03426124</td><td>0.004282655</td><td>0.01284797</td><td>0.006423983</td><td>0</td><td>0.01284797</td><td>0.006423983</td><td>0.002141328</td><td>0.00856531</td><td>0.004282655</td><td>0.04710921</td><td>0.02569593</td><td>0.00856531</td><td>0.0620985</td><td>0.3211991</td><td>0.0385439</td><td>0.130621</td><td>0.03426124</td><td>0</td><td>0.002141328</td><td>0.01284797</td><td>0.02783726</td><td>0.01070664</td><td>0.002141328</td><td>0.2847966</td><td>0.002141328</td><td>0.006423983</td><td>0.01070664</td><td>0.00856531</td><td>0.05567452</td><td>0.0620985</td><td>0.05995717</td><td>0.09850107</td><td>0.05567452</td><td>0.004282655</td><td>0.2398287</td><td>0.03211991</td><td>0.006423983</td><td>0.00856531</td><td>0.1948608</td><td>0.03211991</td><td>0.06423983</td><td>0.004282655</td><td>0.01284797</td><td>0.07280514</td><td>0.006423983</td><td>0.04710921</td><td>0.01713062</td><td>0.006423983</td></tr>
	<tr><th scope=row>2</th><td>british</td><td>0.2960199</td><td>0.03358209</td><td>0.05472637</td><td>0.003731343</td><td>0.03731343</td><td>0</td><td>0.002487562</td><td>0.03109453</td><td>0.2699005</td><td>0.02114428</td><td>0.006218905</td><td>0.05223881</td><td>0.01865672</td><td>0</td><td>0.1965174</td><td>0.004975124</td><td>0.1666667</td><td>0.02238806</td><td>0.003731343</td><td>0.1007463</td><td>0.004975124</td><td>0.001243781</td><td>0.04477612</td><td>0.1355721</td><td>0.5422886</td><td>0.03233831</td><td>0.01243781</td><td>0.02238806</td><td>0.004975124</td><td>0.002487562</td><td>0.07587065</td><td>0.039801</td><td>0.03233831</td><td>0.07462687</td><td>0.1343284</td><td>0.0199005</td><td>0.03731343</td><td>0</td><td>0.001243781</td><td>0.009950249</td><td>0</td><td>0.004975124</td><td>0</td><td>0.02238806</td><td>0.039801</td><td>0.08208955</td><td>0.01119403</td><td>0.006218905</td><td>0.08457711</td><td>0.07089552</td><td>0.02114428</td><td>0.007462687</td><td>0.02736318</td><td>0.01368159</td><td>0.02736318</td><td>0.02860697</td><td>0.008706468</td><td>0.07089552</td><td>0.01368159</td><td>0.01616915</td><td>0.3333333</td><td>0.0460199</td><td>0.001243781</td><td>0.008706468</td><td>0.004975124</td><td>0.009950249</td><td>0.02363184</td><td>0.05472637</td><td>0.003731343</td><td>0.02736318</td><td>0.006218905</td><td>0.01492537</td><td>0</td><td>0.1952736</td><td>0.5422886</td><td>0</td><td>0</td><td>0.02363184</td><td>0.1057214</td><td>0.01243781</td><td>0.003731343</td><td>0</td><td>0.04353234</td><td>0.01492537</td><td>0.002487562</td><td>0.01741294</td><td>0.01741294</td><td>0.007462687</td><td>0.5808458</td><td>0.01492537</td><td>0.2238806</td><td>0.07089552</td><td>0.002487562</td><td>0.1169154</td><td>0.06716418</td><td>0.0659204</td><td>0.0460199</td><td>0.06716418</td><td>0.004975124</td><td>0.03233831</td><td>0.3880597</td><td>0.004975124</td><td>0.008706468</td><td>0.1293532</td><td>0</td><td>0.0199005</td><td>0.0199005</td><td>0.01865672</td><td>0.002487562</td><td>0</td><td>0.001243781</td><td>0.08084577</td><td>0</td><td>0.001243781</td><td>0.008706468</td><td>0.07587065</td><td>0.01741294</td><td>0.2039801</td><td>0.03233831</td><td>0.02487562</td><td>0.05970149</td><td>0.02238806</td><td>0.1554726</td><td>0</td><td>0.003731343</td><td>0.04975124</td><td>0.006218905</td><td>0.009950249</td><td>0.009950249</td><td>0.002487562</td><td>0.008706468</td><td>0.009950249</td><td>0.01741294</td><td>0</td><td>0.3569652</td><td>0.0199005</td><td>0.01741294</td><td>0</td><td>0.039801</td><td>0</td><td>0</td><td>0.0721393</td><td>0.09452736</td><td>0</td><td>0.08706468</td><td>0.25</td><td>0.09577114</td><td>0.2674129</td><td>0.06840796</td><td>0.009950249</td><td>0</td><td>0.02736318</td><td>0.01368159</td><td>0.06467662</td><td>0.03606965</td><td>0</td><td>0.03731343</td><td>0.002487562</td><td>0.01492537</td><td>0.04353234</td><td>0.3432836</td><td>0.01243781</td><td>0.04850746</td><td>0.004975124</td><td>0.05721393</td><td>0.1791045</td><td>0.2649254</td><td>0.01368159</td><td>0.07711443</td><td>0.06218905</td><td>0.002487562</td><td>0.0199005</td><td>0.02860697</td><td>0</td><td>0.02238806</td><td>0.002487562</td><td>0.02860697</td><td>0.002487562</td><td>0.0261194</td><td>0</td><td>0.641791</td><td>0.1032338</td><td>0.05223881</td><td>0.004975124</td><td>0.03233831</td><td>0.01368159</td><td>0.02860697</td><td>0.001243781</td><td>0.001243781</td><td>0.02363184</td><td>0.02487562</td><td>0.007462687</td><td>0.02860697</td><td>0.001243781</td><td>0.007462687</td><td>0.01492537</td><td>0.003731343</td><td>0.004975124</td><td>0.02860697</td><td>0.02114428</td><td>0.1057214</td><td>0.01119403</td><td>0.003731343</td><td>0.02860697</td><td>0.006218905</td><td>0</td><td>0.006218905</td><td>0.01492537</td><td>0.01243781</td><td>0.004975124</td><td>0.002487562</td><td>0.039801</td><td>0.03233831</td><td>0.01119403</td><td>0.06094527</td><td>0.5646766</td><td>0.0261194</td><td>0.01368159</td><td>0.05099502</td><td>0</td><td>0.001243781</td><td>0</td><td>0.07711443</td><td>0.008706468</td><td>0</td><td>0.0659204</td><td>0</td><td>0.01119403</td><td>0.002487562</td><td>0.003731343</td><td>0.2400498</td><td>0.002487562</td><td>0.14801</td><td>0.10199</td><td>0.08830846</td><td>0.01865672</td><td>0.221393</td><td>0.009950249</td><td>0.01865672</td><td>0.10199</td><td>0.2089552</td><td>0.09577114</td><td>0.08208955</td><td>0.0659204</td><td>0.05099502</td><td>0.03233831</td><td>0.009950249</td><td>0.08333333</td><td>0.0261194</td><td>0.003731343</td></tr>
	<tr><th scope=row>3</th><td>cajun_creole</td><td>0.1882277</td><td>0.01164295</td><td>0.007761966</td><td>0.02522639</td><td>0.009055627</td><td>0.002587322</td><td>0.01099612</td><td>0.04010349</td><td>0.04139715</td><td>0.005174644</td><td>0.06080207</td><td>0.232859</td><td>0.1060802</td><td>0</td><td>0.05109961</td><td>0.450194</td><td>0.3208279</td><td>0.0148771</td><td>0.09831824</td><td>0.08602846</td><td>0.1138422</td><td>0.001940492</td><td>0.225097</td><td>0.07179819</td><td>0.3221216</td><td>0.02134541</td><td>0.009702458</td><td>0.05433376</td><td>0.01940492</td><td>0.0006468305</td><td>0.03428202</td><td>0.2580854</td><td>0.4003881</td><td>0.01293661</td><td>0.1125485</td><td>0.005821475</td><td>0.4793014</td><td>0.001940492</td><td>0.01811125</td><td>0.09184994</td><td>0</td><td>0.003234153</td><td>0.001940492</td><td>0.01423027</td><td>0.007115136</td><td>0.3518758</td><td>0.01228978</td><td>0.01681759</td><td>0.0297542</td><td>0.2128072</td><td>0.01875809</td><td>0.005821475</td><td>0.006468305</td><td>0.01099612</td><td>0.01681759</td><td>0.1934023</td><td>0.006468305</td><td>0.09379043</td><td>0.0148771</td><td>0.01552393</td><td>0.1332471</td><td>0.0316947</td><td>0.003234153</td><td>0.05756792</td><td>0</td><td>0.03686934</td><td>0.0006468305</td><td>0.009055627</td><td>0.1791721</td><td>0.02134541</td><td>0.008408797</td><td>0.003234153</td><td>0.01164295</td><td>0.4178525</td><td>0.1532988</td><td>0.002587322</td><td>0</td><td>0.03040103</td><td>0.03492885</td><td>0.03298836</td><td>0.005821475</td><td>0.0006468305</td><td>0.04851229</td><td>0.02652005</td><td>0.002587322</td><td>0.007761966</td><td>0.04463131</td><td>0.03234153</td><td>0.2910737</td><td>0.02005175</td><td>0.3531695</td><td>0.03363519</td><td>0</td><td>0.648771</td><td>0.003880983</td><td>0.003880983</td><td>0.03298836</td><td>0.03751617</td><td>0</td><td>0.5905563</td><td>0.4391979</td><td>0.03945666</td><td>0.06080207</td><td>0.04786546</td><td>0</td><td>0.009055627</td><td>0.1849935</td><td>0.009702458</td><td>0.02910737</td><td>0.01034929</td><td>0.03234153</td><td>0.1267788</td><td>0.001940492</td><td>0.01746442</td><td>0.0148771</td><td>0.0698577</td><td>0</td><td>0.1442432</td><td>0.1021992</td><td>0.008408797</td><td>0.1921087</td><td>0.004527814</td><td>0.1636481</td><td>0.01552393</td><td>0.02587322</td><td>0.02716688</td><td>0.0148771</td><td>0.04915912</td><td>0.01099612</td><td>0</td><td>0.05174644</td><td>0.04721863</td><td>0.07050453</td><td>0.001293661</td><td>0.106727</td><td>0.07826649</td><td>0.001940492</td><td>0</td><td>0.0297542</td><td>0.005174644</td><td>0.007115136</td><td>0.05368693</td><td>0.08602846</td><td>0.003880983</td><td>0.01681759</td><td>0.5310479</td><td>0.2600259</td><td>0.8499353</td><td>0.0232859</td><td>0.1455369</td><td>0.01940492</td><td>0.1694696</td><td>0.03751617</td><td>0.2386805</td><td>0.06403622</td><td>0.01746442</td><td>0.02069858</td><td>0.02005175</td><td>0.02587322</td><td>0.02522639</td><td>1.504528</td><td>0.01099612</td><td>0.003880983</td><td>0.01681759</td><td>0.03945666</td><td>0.03751617</td><td>0.2910737</td><td>0.02457956</td><td>0.005821475</td><td>0.3589909</td><td>0.0232859</td><td>0.11837</td><td>0.347348</td><td>0.0006468305</td><td>0.02134541</td><td>0</td><td>0.01746442</td><td>0.001293661</td><td>0.01034929</td><td>0.001293661</td><td>0.6423027</td><td>0.4301423</td><td>0.2994825</td><td>0.06274256</td><td>0.0232859</td><td>0.4081501</td><td>0.02199224</td><td>0.002587322</td><td>0.0006468305</td><td>0.0148771</td><td>0.004527814</td><td>0.009702458</td><td>0.005174644</td><td>0.0006468305</td><td>0.003880983</td><td>0.01617076</td><td>0.3059508</td><td>0.08085382</td><td>0.06468305</td><td>0.1280724</td><td>0.01681759</td><td>0.06921087</td><td>0.02263907</td><td>0.01617076</td><td>0.009055627</td><td>0.003234153</td><td>0.01164295</td><td>0.04851229</td><td>0.01681759</td><td>0.001293661</td><td>0.005174644</td><td>0.01811125</td><td>0.01034929</td><td>0.003880983</td><td>0.09573092</td><td>0.2005175</td><td>0.04915912</td><td>0.004527814</td><td>0.01164295</td><td>0.0006468305</td><td>0</td><td>0.03557568</td><td>0.2768435</td><td>0.005174644</td><td>0.0006468305</td><td>0.4353169</td><td>0.003880983</td><td>0.0006468305</td><td>0.04010349</td><td>0.0006468305</td><td>0.07697283</td><td>0.001940492</td><td>0.04786546</td><td>0.202458</td><td>0.0465718</td><td>0.01552393</td><td>0.2199224</td><td>0.01034929</td><td>0.003234153</td><td>0.02652005</td><td>0.2399741</td><td>0.04980595</td><td>0.06791721</td><td>0.126132</td><td>0.03622251</td><td>0.09443726</td><td>0.001940492</td><td>0.02199224</td><td>0.008408797</td><td>0.008408797</td></tr>
	<tr><th scope=row>4</th><td>chinese</td><td>0.04826038</td><td>0</td><td>0.01720913</td><td>0.01346801</td><td>0.009726899</td><td>0.003367003</td><td>0.03441826</td><td>0.009726899</td><td>0.03741115</td><td>0.01197157</td><td>0.01271979</td><td>0.005237561</td><td>0.1234568</td><td>0.04077815</td><td>0.06247662</td><td>0.0976431</td><td>0.197905</td><td>0.02095024</td><td>0.1462776</td><td>0.005611672</td><td>0.1720913</td><td>0.06397306</td><td>0.137673</td><td>0.1358025</td><td>0.04190049</td><td>0.000748223</td><td>0.09390198</td><td>0.06995885</td><td>0</td><td>0.001870557</td><td>0.1417883</td><td>0.01346801</td><td>0.0422746</td><td>0.000748223</td><td>0.01234568</td><td>0.004489338</td><td>0.4975683</td><td>0.0003741115</td><td>0.05499439</td><td>0.2199776</td><td>0.2259633</td><td>0</td><td>0.0003741115</td><td>0.02356902</td><td>0.001496446</td><td>0.08118219</td><td>0.01758324</td><td>0.09165731</td><td>0.02431725</td><td>0.1859334</td><td>0.01646091</td><td>0.01646091</td><td>0.03404415</td><td>0.003367003</td><td>0.003367003</td><td>0.1328096</td><td>0.01870557</td><td>0.375982</td><td>0.000748223</td><td>0.004489338</td><td>0.02020202</td><td>0.002244669</td><td>0.000748223</td><td>0.0587355</td><td>0.0228208</td><td>0.005985784</td><td>0.008604564</td><td>0.1361766</td><td>0.007856341</td><td>0.002992892</td><td>0.0003741115</td><td>0.002992892</td><td>0.003367003</td><td>0.147774</td><td>0.2607557</td><td>0.01384212</td><td>0</td><td>0.004489338</td><td>0.009352787</td><td>0.02095024</td><td>0.005985784</td><td>0.0003741115</td><td>0.01683502</td><td>0.008230453</td><td>0.04190049</td><td>0.03329592</td><td>0.08866442</td><td>0.000748223</td><td>0.1402918</td><td>0.02020202</td><td>0.3920688</td><td>0.03554059</td><td>0.0003741115</td><td>0.6311261</td><td>0.5548073</td><td>0.00261878</td><td>0.0194538</td><td>0.01084923</td><td>0.0003741115</td><td>0.369248</td><td>0.2947999</td><td>0.02731014</td><td>0.01122334</td><td>0.002244669</td><td>0.1219603</td><td>0.09614665</td><td>0.04077815</td><td>0.004115226</td><td>0.001122334</td><td>0</td><td>0.00748223</td><td>0.08305275</td><td>0</td><td>0.003367003</td><td>0.0490086</td><td>0.06995885</td><td>0.004115226</td><td>0.09577254</td><td>0.005985784</td><td>0.01571268</td><td>0.05798728</td><td>0.01084923</td><td>0.03965582</td><td>0.01608679</td><td>0.03404415</td><td>0.1114852</td><td>0.02955481</td><td>0.1137299</td><td>0.0003741115</td><td>0.0003741115</td><td>0.004489338</td><td>0.01758324</td><td>0.02319491</td><td>0.0003741115</td><td>0.02768425</td><td>0.1215862</td><td>0.005237561</td><td>0.01010101</td><td>0.01234568</td><td>0</td><td>0.0003741115</td><td>0.1335578</td><td>0.01459035</td><td>0.1197157</td><td>0.003741115</td><td>1.124205</td><td>0.05649083</td><td>0.4863449</td><td>0.07182941</td><td>0.000748223</td><td>0.1316872</td><td>0.005237561</td><td>0.001496446</td><td>0.006359895</td><td>0.08492331</td><td>0.00261878</td><td>0.09203143</td><td>0.1769547</td><td>0</td><td>0.07557052</td><td>0.6483352</td><td>0.06621773</td><td>0.005985784</td><td>0.0130939</td><td>0.2083801</td><td>0.01608679</td><td>0.1735877</td><td>0.01234568</td><td>0.001870557</td><td>0.2835765</td><td>0.03965582</td><td>0.02469136</td><td>0.4672652</td><td>0.0003741115</td><td>0.0490086</td><td>0.05274972</td><td>0.0003741115</td><td>0</td><td>0.001122334</td><td>0.0003741115</td><td>0.4627759</td><td>1.290685</td><td>0.01122334</td><td>0.2274598</td><td>0.02581369</td><td>0.01421624</td><td>0.1215862</td><td>0.005611672</td><td>0.5566779</td><td>0.02731014</td><td>0.0003741115</td><td>0.00261878</td><td>0.07369996</td><td>0.07631874</td><td>0.01122334</td><td>0.02731014</td><td>0.09390198</td><td>0.1230827</td><td>0.05125327</td><td>0.001870557</td><td>0.01982791</td><td>0.1709689</td><td>0.005237561</td><td>0.005985784</td><td>0.8395062</td><td>0.008978676</td><td>0.01346801</td><td>0.0194538</td><td>0.005611672</td><td>0.06397306</td><td>0.002244669</td><td>0.3561541</td><td>0.0490086</td><td>0.01870557</td><td>0.08567153</td><td>0.5308642</td><td>0.03142536</td><td>0.003367003</td><td>0.009352787</td><td>0.0003741115</td><td>0.01459035</td><td>0.0325477</td><td>0.003741115</td><td>0.09315376</td><td>0.06621773</td><td>0.04152637</td><td>0.004489338</td><td>0</td><td>0.008604564</td><td>0.002244669</td><td>0.01795735</td><td>0.002992892</td><td>0.008230453</td><td>0.2708567</td><td>0.325477</td><td>0.01271979</td><td>0.4223719</td><td>0.003741115</td><td>0.008978676</td><td>0.002244669</td><td>0.3243547</td><td>0.01047512</td><td>0.2592593</td><td>0.01459035</td><td>0.01234568</td><td>0.03105125</td><td>0.000748223</td><td>0.007856341</td><td>0.01234568</td><td>0.01197157</td></tr>
	<tr><th scope=row>5</th><td>filipino</td><td>0.04370861</td><td>0.001324503</td><td>0.002649007</td><td>0.02251656</td><td>0.03178808</td><td>0.00397351</td><td>0.006622517</td><td>0.005298013</td><td>0.0397351</td><td>0.00397351</td><td>0.002649007</td><td>0.1615894</td><td>0.09271523</td><td>0.01324503</td><td>0.1284768</td><td>0.09271523</td><td>0.2754967</td><td>0.00794702</td><td>0.04900662</td><td>0.02781457</td><td>0.05298013</td><td>0.01192053</td><td>0.08476821</td><td>0.1192053</td><td>0.1165563</td><td>0</td><td>0.08874172</td><td>0.03576159</td><td>0</td><td>0.001324503</td><td>0.1774834</td><td>0.01059603</td><td>0.04768212</td><td>0.01986755</td><td>0.04635762</td><td>0.002649007</td><td>0.3271523</td><td>0.001324503</td><td>0.04768212</td><td>0.08344371</td><td>0.02384106</td><td>0</td><td>0.00397351</td><td>0.002649007</td><td>0.005298013</td><td>0.04635762</td><td>0.03311258</td><td>0.02384106</td><td>0.01059603</td><td>0.1245033</td><td>0.006622517</td><td>0.197351</td><td>0.006622517</td><td>0.05562914</td><td>0.005298013</td><td>0.1615894</td><td>0.006622517</td><td>0.1059603</td><td>0</td><td>0.001324503</td><td>0.07549669</td><td>0.01721854</td><td>0</td><td>0.02781457</td><td>0.006622517</td><td>0.01059603</td><td>0.006622517</td><td>0.01589404</td><td>0.009271523</td><td>0.001324503</td><td>0</td><td>0.001324503</td><td>0.001324503</td><td>0.04900662</td><td>0.2397351</td><td>0.03576159</td><td>0</td><td>0.006622517</td><td>0.0397351</td><td>0.00397351</td><td>0.001324503</td><td>0</td><td>0.01854305</td><td>0.009271523</td><td>0.00794702</td><td>0.1430464</td><td>0.03178808</td><td>0.002649007</td><td>0.1311258</td><td>0.002649007</td><td>0.1019868</td><td>0.02913907</td><td>0</td><td>0.6675497</td><td>0.1456954</td><td>0.00397351</td><td>0.03311258</td><td>0.01854305</td><td>0</td><td>0.2238411</td><td>0.3562914</td><td>0.00794702</td><td>0.009271523</td><td>0.005298013</td><td>0.01324503</td><td>0.01721854</td><td>0.02649007</td><td>0.01854305</td><td>0.002649007</td><td>0</td><td>0.01589404</td><td>0.07682119</td><td>0</td><td>0.005298013</td><td>0.03178808</td><td>0.02781457</td><td>0.002649007</td><td>0.0384106</td><td>0.03708609</td><td>0.006622517</td><td>0.1854305</td><td>0.00397351</td><td>0.0807947</td><td>0.001324503</td><td>0.005298013</td><td>0.01589404</td><td>0.03708609</td><td>0.02384106</td><td>0</td><td>0</td><td>0.01589404</td><td>0.03046358</td><td>0.00794702</td><td>0</td><td>0.2529801</td><td>0.05827815</td><td>0.001324503</td><td>0</td><td>0.001324503</td><td>0</td><td>0.001324503</td><td>0.02781457</td><td>0.00794702</td><td>0.06357616</td><td>0.001324503</td><td>0.6304636</td><td>0.07549669</td><td>0.6172185</td><td>0.01324503</td><td>0.006622517</td><td>0.04370861</td><td>0.01456954</td><td>0.002649007</td><td>0.01456954</td><td>0.0397351</td><td>0.00794702</td><td>0.04238411</td><td>0.02384106</td><td>0</td><td>0.00794702</td><td>0.6768212</td><td>0.1192053</td><td>0.00397351</td><td>0.005298013</td><td>0.2807947</td><td>0.08609272</td><td>0.1192053</td><td>0.01721854</td><td>0.03443709</td><td>0.09536424</td><td>0.001324503</td><td>0.01986755</td><td>0.1695364</td><td>0</td><td>0.00397351</td><td>0.01456954</td><td>0</td><td>0.00397351</td><td>0</td><td>0.001324503</td><td>0.6397351</td><td>0.6768212</td><td>0.01854305</td><td>0.02384106</td><td>0.01986755</td><td>0.01986755</td><td>0.02251656</td><td>0.001324503</td><td>0.0397351</td><td>0.02649007</td><td>0.001324503</td><td>0.002649007</td><td>0.005298013</td><td>0.01324503</td><td>0.02516556</td><td>0.02516556</td><td>0.09801325</td><td>0.03178808</td><td>0.01589404</td><td>0.006622517</td><td>0.005298013</td><td>0.02781457</td><td>0.002649007</td><td>0.005298013</td><td>0.384106</td><td>0.00397351</td><td>0.03576159</td><td>0.005298013</td><td>0</td><td>0.04238411</td><td>0.00794702</td><td>0.07549669</td><td>0.01192053</td><td>0.009271523</td><td>0.0410596</td><td>0.4225166</td><td>0.05430464</td><td>0.03708609</td><td>0.00397351</td><td>0.001324503</td><td>0.0384106</td><td>0.0410596</td><td>0.00794702</td><td>0.001324503</td><td>0.01721854</td><td>0.1615894</td><td>0.002649007</td><td>0.001324503</td><td>0.001324503</td><td>0.006622517</td><td>0.009271523</td><td>0.006622517</td><td>0.04900662</td><td>0.1430464</td><td>0.2278146</td><td>0.01192053</td><td>0.4609272</td><td>0.005298013</td><td>0.001324503</td><td>0.001324503</td><td>0.2066225</td><td>0.03311258</td><td>0.02251656</td><td>0.01192053</td><td>0.02251656</td><td>0.04635762</td><td>0</td><td>0.02781457</td><td>0.00397351</td><td>0.00794702</td></tr>
	<tr><th scope=row>6</th><td>french</td><td>0.2244898</td><td>0.0143613</td><td>0.0665155</td><td>0.006046863</td><td>0.04799698</td><td>0.001133787</td><td>0.01587302</td><td>0.0547997</td><td>0.04875283</td><td>0.01322751</td><td>0.0600907</td><td>0.1145125</td><td>0.09297052</td><td>0</td><td>0.06500378</td><td>0.04232804</td><td>0.2739985</td><td>0.01965231</td><td>0.03023432</td><td>0.1001512</td><td>0.04119426</td><td>0.004913076</td><td>0.1152683</td><td>0.04270597</td><td>0.4391534</td><td>0.005668934</td><td>0.007558579</td><td>0.01058201</td><td>0.03514739</td><td>0.003779289</td><td>0.09637188</td><td>0.02305367</td><td>0.06122449</td><td>0.009070295</td><td>0.2093726</td><td>0.02683296</td><td>0.2025699</td><td>0.005291005</td><td>0.003023432</td><td>0.004157218</td><td>0.001133787</td><td>0.005291005</td><td>0.0003779289</td><td>0.04157218</td><td>0.08956916</td><td>0.1659108</td><td>0.01247166</td><td>0.005291005</td><td>0.04006047</td><td>0.2033258</td><td>0.0143613</td><td>0.008692366</td><td>0.02191988</td><td>0.006424792</td><td>0.03439153</td><td>0.08730159</td><td>0.007936508</td><td>0.05177627</td><td>0.003779289</td><td>0.01058201</td><td>0.2641723</td><td>0.03061224</td><td>0.004913076</td><td>0.009826153</td><td>0.003401361</td><td>0.006802721</td><td>0.004913076</td><td>0.01814059</td><td>0.02267574</td><td>0.0718065</td><td>0.00718065</td><td>0.01662887</td><td>0.004535147</td><td>0.2736206</td><td>0.4512472</td><td>0.01587302</td><td>0</td><td>0.09674981</td><td>0.1103553</td><td>0.06462585</td><td>0.03817082</td><td>0.002645503</td><td>0.05668934</td><td>0.03779289</td><td>0.006424792</td><td>0.01549509</td><td>0.009070295</td><td>0.04799698</td><td>0.3034769</td><td>0.03401361</td><td>0.5506425</td><td>0.03514739</td><td>0</td><td>0.2936508</td><td>0.01662887</td><td>0.0170068</td><td>0.04686319</td><td>0.1084656</td><td>0.001889645</td><td>0.08654573</td><td>0.3272865</td><td>0.0260771</td><td>0.02834467</td><td>0.09334845</td><td>0.0003779289</td><td>0.02721088</td><td>0.01587302</td><td>0.03703704</td><td>0.01511716</td><td>0.002645503</td><td>0.0003779289</td><td>0.1734694</td><td>0.02040816</td><td>0.001889645</td><td>0.0007558579</td><td>0.0600907</td><td>0.01284958</td><td>0.3261527</td><td>0.1069539</td><td>0.001889645</td><td>0.1587302</td><td>0.05253212</td><td>0.1991686</td><td>0.02229781</td><td>0.02229781</td><td>0.03514739</td><td>0.01473923</td><td>0.0287226</td><td>0.02910053</td><td>0</td><td>0.01776266</td><td>0.007936508</td><td>0.006424792</td><td>0</td><td>0.1829176</td><td>0.02343159</td><td>0.02078609</td><td>0.0003779289</td><td>0.009826153</td><td>0.002267574</td><td>0.004157218</td><td>0.08843537</td><td>0.09637188</td><td>0.004535147</td><td>0.05291005</td><td>0.3877551</td><td>0.3571429</td><td>0.2849584</td><td>0.08956916</td><td>0.01814059</td><td>0.003401361</td><td>0.0143613</td><td>0.04346183</td><td>0.1855631</td><td>0.03703704</td><td>0.004157218</td><td>0.01095994</td><td>0.003023432</td><td>0.008692366</td><td>0.03476946</td><td>0.4591837</td><td>0.04195011</td><td>0.008314437</td><td>0.02834467</td><td>0.02834467</td><td>0.1130008</td><td>0.111867</td><td>0.02456538</td><td>0.009070295</td><td>0.1617536</td><td>0.02305367</td><td>0.0313681</td><td>0.01284958</td><td>0.005668934</td><td>0.02305367</td><td>0.006802721</td><td>0.04195011</td><td>0.01889645</td><td>0.01473923</td><td>0</td><td>0.6213152</td><td>0.03628118</td><td>0.0117158</td><td>0.006802721</td><td>0.07974301</td><td>0.007936508</td><td>0.03174603</td><td>0.0007558579</td><td>0.001511716</td><td>0.1216931</td><td>0.002645503</td><td>0.0117158</td><td>0.0287226</td><td>0.008314437</td><td>0.009070295</td><td>0.01965231</td><td>0.01814059</td><td>0.02116402</td><td>0.05404384</td><td>0.01209373</td><td>0.006802721</td><td>0.0457294</td><td>0.008314437</td><td>0.02116402</td><td>0.002645503</td><td>0.001511716</td><td>0.0143613</td><td>0.07671958</td><td>0.07142857</td><td>0.001133787</td><td>0.01133787</td><td>0.03514739</td><td>0.02305367</td><td>0.007936508</td><td>0.04610733</td><td>0.4368859</td><td>0.01209373</td><td>0.009448224</td><td>0.02267574</td><td>0</td><td>0</td><td>0.01587302</td><td>0.2018141</td><td>0.01247166</td><td>0.001889645</td><td>0.1613757</td><td>0.0003779289</td><td>0.0003779289</td><td>0.008314437</td><td>0.0007558579</td><td>0.2256236</td><td>0.02343159</td><td>0.1523054</td><td>0.06386999</td><td>0.1235828</td><td>0.0170068</td><td>0.249811</td><td>0.004535147</td><td>0.009448224</td><td>0.09372638</td><td>0.313681</td><td>0.07482993</td><td>0.2505669</td><td>0.007558579</td><td>0.0287226</td><td>0.03552532</td><td>0.008692366</td><td>0.1311413</td><td>0.03817082</td><td>0.03401361</td></tr>
	<tr><th scope=row>7</th><td>greek</td><td>0.08510638</td><td>0.02723404</td><td>0.02468085</td><td>0.01276596</td><td>0.004255319</td><td>0.005106383</td><td>0.02893617</td><td>0.002553191</td><td>0.0587234</td><td>0.02212766</td><td>0.06468085</td><td>0.03234043</td><td>0.05702128</td><td>0</td><td>0.04680851</td><td>0.1029787</td><td>0.3387234</td><td>0.006808511</td><td>0.0587234</td><td>0.1055319</td><td>0.08595745</td><td>0.002553191</td><td>0.05957447</td><td>0.01191489</td><td>0.1421277</td><td>0.002553191</td><td>0.001702128</td><td>0.01021277</td><td>0.02553191</td><td>0.001702128</td><td>0.02723404</td><td>0.02468085</td><td>0.02723404</td><td>0.005957447</td><td>0.4919149</td><td>0.04680851</td><td>0.1948936</td><td>0.02723404</td><td>0.004255319</td><td>0.01191489</td><td>0</td><td>0.007659574</td><td>0</td><td>0.01191489</td><td>0.006808511</td><td>0.2314894</td><td>0.005106383</td><td>0.008510638</td><td>0.106383</td><td>0.2748936</td><td>0.02042553</td><td>0.002553191</td><td>0.004255319</td><td>0.0008510638</td><td>0.007659574</td><td>0.09021277</td><td>0.01361702</td><td>0.009361702</td><td>0</td><td>0.0187234</td><td>0.04595745</td><td>0.03404255</td><td>0.2170213</td><td>0.03829787</td><td>0.2246809</td><td>0.04170213</td><td>0.002553191</td><td>0.001702128</td><td>0.05957447</td><td>0.01446809</td><td>0.1480851</td><td>0.04680851</td><td>0.0212766</td><td>0.44</td><td>0.1753191</td><td>0.05446809</td><td>0</td><td>0.1948936</td><td>0.02723404</td><td>0.03914894</td><td>0.01787234</td><td>0.3812766</td><td>0.01787234</td><td>0.02723404</td><td>0.0008510638</td><td>0</td><td>0.03744681</td><td>0.05617021</td><td>0.1157447</td><td>0.02978723</td><td>0.7582979</td><td>0.03659574</td><td>0</td><td>0.5361702</td><td>0.005957447</td><td>0.005957447</td><td>0.01446809</td><td>0.09617021</td><td>0.1838298</td><td>0.1395745</td><td>0.5531915</td><td>0.02978723</td><td>0.001702128</td><td>0.005957447</td><td>0</td><td>0.0612766</td><td>0.01361702</td><td>0</td><td>0.01361702</td><td>0.001702128</td><td>0.001702128</td><td>0.3795745</td><td>0.1310638</td><td>0.0008510638</td><td>0.0008510638</td><td>0.07489362</td><td>0.1157447</td><td>0.1268085</td><td>0.07744681</td><td>0.01702128</td><td>0.1208511</td><td>0.006808511</td><td>0.5480851</td><td>0.01021277</td><td>0.06978723</td><td>0.01191489</td><td>0.005106383</td><td>0.02042553</td><td>0.03234043</td><td>0</td><td>0.01361702</td><td>0.005957447</td><td>0.01021277</td><td>0</td><td>0.07574468</td><td>0.06978723</td><td>0.1429787</td><td>0</td><td>0.01106383</td><td>0.0008510638</td><td>0.01106383</td><td>0.02212766</td><td>0.02297872</td><td>0.002553191</td><td>0.04085106</td><td>0.7021277</td><td>0.7795745</td><td>0.4791489</td><td>0.03914894</td><td>0.3429787</td><td>0</td><td>0.02723404</td><td>0.04170213</td><td>0.2195745</td><td>0.03319149</td><td>0.03489362</td><td>0.01021277</td><td>0.0008510638</td><td>0.006808511</td><td>0.02382979</td><td>0.7361702</td><td>0.005106383</td><td>0.1285106</td><td>0.04425532</td><td>0.01787234</td><td>0.08</td><td>0.08425532</td><td>0.1582979</td><td>0.01021277</td><td>0.2561702</td><td>0.005106383</td><td>0.01021277</td><td>0.05446809</td><td>0.009361702</td><td>0.02468085</td><td>0.001702128</td><td>0.05361702</td><td>0.001702128</td><td>0.002553191</td><td>0</td><td>0.6357447</td><td>0.05276596</td><td>0.002553191</td><td>0.01787234</td><td>0.03319149</td><td>0.05531915</td><td>0.02978723</td><td>0.0008510638</td><td>0.01021277</td><td>0.02468085</td><td>0.001702128</td><td>0.005106383</td><td>0.005106383</td><td>0</td><td>0.01361702</td><td>0.01191489</td><td>0.03404255</td><td>0.05617021</td><td>0.0493617</td><td>0.006808511</td><td>0.01446809</td><td>0.02042553</td><td>0.003404255</td><td>0.02042553</td><td>0.005106383</td><td>0.005106383</td><td>0.09361702</td><td>0.07914894</td><td>0.02297872</td><td>0.003404255</td><td>0.005957447</td><td>0.008510638</td><td>0.01702128</td><td>0.02723404</td><td>0.02042553</td><td>0.1242553</td><td>0.01361702</td><td>0.001702128</td><td>0.003404255</td><td>0</td><td>0</td><td>0.009361702</td><td>0.06042553</td><td>0.005106383</td><td>0</td><td>0.4221277</td><td>0.004255319</td><td>0</td><td>0.01191489</td><td>0.004255319</td><td>0.05276596</td><td>0.0008510638</td><td>0.02978723</td><td>0.04680851</td><td>0.146383</td><td>0.01361702</td><td>0.1574468</td><td>0.01617021</td><td>0.02723404</td><td>0.002553191</td><td>0.1489362</td><td>0.04765957</td><td>0.1693617</td><td>0.002553191</td><td>0.01276596</td><td>0.03829787</td><td>0.2382979</td><td>0.02382979</td><td>0.05957447</td><td>0.04170213</td></tr>
	<tr><th scope=row>8</th><td>indian</td><td>0.04995005</td><td>0.007992008</td><td>0.04129204</td><td>0.002664003</td><td>0.01498501</td><td>0.001665002</td><td>0.02364302</td><td>0</td><td>0.03663004</td><td>0.001998002</td><td>0.004995005</td><td>0.07692308</td><td>0.03962704</td><td>0.0003330003</td><td>0.01931402</td><td>0.04995005</td><td>0.2291042</td><td>0.01431901</td><td>0.08424908</td><td>0.02664003</td><td>0.08558109</td><td>0.006327006</td><td>0.06393606</td><td>0.07326007</td><td>0.1428571</td><td>0.006993007</td><td>0.01232101</td><td>0.05361305</td><td>0</td><td>0.1958042</td><td>0.07092907</td><td>0.1245421</td><td>0.01132201</td><td>0.001332001</td><td>0.02064602</td><td>0.004329004</td><td>0.2710623</td><td>0.06560107</td><td>0.1252081</td><td>0.5141525</td><td>0.0006660007</td><td>0.000999001</td><td>0.0006660007</td><td>0.002331002</td><td>0.001665002</td><td>0.2540793</td><td>0.009324009</td><td>0.3476523</td><td>0.1814852</td><td>0.3010323</td><td>0.01631702</td><td>0.2104562</td><td>0.006327006</td><td>0.005661006</td><td>0.001665002</td><td>0.06959707</td><td>0.3846154</td><td>0.02997003</td><td>0.0003330003</td><td>0.007326007</td><td>0.0952381</td><td>0.008991009</td><td>0.000999001</td><td>0.04562105</td><td>0.03230103</td><td>0.5204795</td><td>0.2870463</td><td>0.004662005</td><td>0.05228105</td><td>0.002331002</td><td>0.001998002</td><td>0.005328005</td><td>0.000999001</td><td>0.07592408</td><td>0.04428904</td><td>0.02064602</td><td>0</td><td>0.01764902</td><td>0.006327006</td><td>0.03829504</td><td>0.05028305</td><td>0.001665002</td><td>0.02297702</td><td>0.02630703</td><td>0.01165501</td><td>0.008991009</td><td>0.04562105</td><td>0.002664003</td><td>0.1768232</td><td>0.02331002</td><td>0.5544456</td><td>0.05661006</td><td>0.2877123</td><td>0.5444555</td><td>0.4911755</td><td>0.01731602</td><td>0.006327006</td><td>0.03163503</td><td>0.04695305</td><td>0.3100233</td><td>0.9297369</td><td>0.01798202</td><td>0</td><td>0.03596404</td><td>0</td><td>0.02097902</td><td>0.02630703</td><td>0.00965701</td><td>0.001665002</td><td>0.0003330003</td><td>0.04229104</td><td>0.1994672</td><td>0</td><td>0.003330003</td><td>0.007992008</td><td>0.08558109</td><td>0.03696304</td><td>0.03962704</td><td>0.04528805</td><td>0.000999001</td><td>0.3203463</td><td>0.001998002</td><td>0.1958042</td><td>0.01032301</td><td>0.003996004</td><td>0.02630703</td><td>0.09057609</td><td>0.01665002</td><td>0.02930403</td><td>0.3323343</td><td>0.004329004</td><td>0.01132201</td><td>0.007992008</td><td>0</td><td>0.2117882</td><td>0.05128205</td><td>0.07425907</td><td>0</td><td>0.007992008</td><td>0.0003330003</td><td>0.001332001</td><td>0.01431901</td><td>0.1751582</td><td>0.002664003</td><td>0.02930403</td><td>0.6763237</td><td>0.1411921</td><td>0.6140526</td><td>0.007659008</td><td>0.000999001</td><td>0.0006660007</td><td>0.08091908</td><td>0.001332001</td><td>0.01565102</td><td>0.2061272</td><td>0.000999001</td><td>0.0959041</td><td>0.03296703</td><td>0.0006660007</td><td>0.06227106</td><td>0.5487845</td><td>0.05394605</td><td>0.1378621</td><td>0.02464202</td><td>0.008658009</td><td>0.1598402</td><td>0.5071595</td><td>0.05661006</td><td>0.03896104</td><td>0.2947053</td><td>0.006660007</td><td>0.004662005</td><td>0.1974692</td><td>0.001665002</td><td>0.01798202</td><td>0.04961705</td><td>0.0003330003</td><td>0.03829504</td><td>0</td><td>0.0006660007</td><td>0.7998668</td><td>0.04695305</td><td>0.0003330003</td><td>0.01198801</td><td>0.03862804</td><td>0.005328005</td><td>0.5790876</td><td>0.04528805</td><td>0.01665002</td><td>0.01864802</td><td>0</td><td>0.000999001</td><td>0.001332001</td><td>0</td><td>0.00999001</td><td>0.00965701</td><td>0.02497502</td><td>0.07492507</td><td>0.01931402</td><td>0.01132201</td><td>0.01565102</td><td>0.02197802</td><td>0.000999001</td><td>0.009324009</td><td>0.01165501</td><td>0</td><td>0.06093906</td><td>0.02630703</td><td>0.01265401</td><td>0.004662005</td><td>0.00965701</td><td>0.01465201</td><td>0.005661006</td><td>0.08658009</td><td>0.03529804</td><td>0.1774892</td><td>0.03163503</td><td>0.007659008</td><td>0.002331002</td><td>0</td><td>0.006660007</td><td>0.04395604</td><td>0.006660007</td><td>0.005661006</td><td>0.01365301</td><td>0.4192474</td><td>0.002664003</td><td>0.1694972</td><td>0.003663004</td><td>0.2437562</td><td>0.02963703</td><td>0.01498501</td><td>0.005994006</td><td>0.2477522</td><td>0.05094905</td><td>0.01998002</td><td>0.3220113</td><td>0.01631702</td><td>0.02830503</td><td>0.007659008</td><td>0.08225108</td><td>0.06227106</td><td>0.01831502</td><td>0.0006660007</td><td>0.02430902</td><td>0.07359307</td><td>0.1918082</td><td>0.000999001</td><td>0.007326007</td><td>0.01431901</td></tr>
	<tr><th scope=row>9</th><td>irish</td><td>0.3283358</td><td>0.02998501</td><td>0.01949025</td><td>0.02248876</td><td>0.04647676</td><td>0.002998501</td><td>0.01649175</td><td>0.09445277</td><td>0.3823088</td><td>0.008995502</td><td>0.004497751</td><td>0.07646177</td><td>0.0149925</td><td>0</td><td>0.17991</td><td>0.01649175</td><td>0.2128936</td><td>0.02098951</td><td>0.005997001</td><td>0.05547226</td><td>0.007496252</td><td>0</td><td>0.09145427</td><td>0.1124438</td><td>0.5007496</td><td>0.143928</td><td>0.131934</td><td>0.005997001</td><td>0.005997001</td><td>0.007496252</td><td>0.1814093</td><td>0.01649175</td><td>0.06296852</td><td>0.05847076</td><td>0.1244378</td><td>0.017991</td><td>0.09895052</td><td>0</td><td>0.002998501</td><td>0.004497751</td><td>0</td><td>0.01649175</td><td>0.00149925</td><td>0.02998501</td><td>0.05547226</td><td>0.1289355</td><td>0.02398801</td><td>0.007496252</td><td>0.06446777</td><td>0.08845577</td><td>0.01349325</td><td>0.005997001</td><td>0.01349325</td><td>0.01049475</td><td>0.02398801</td><td>0.1034483</td><td>0.002998501</td><td>0.06446777</td><td>0</td><td>0.008995502</td><td>0.2608696</td><td>0.01649175</td><td>0.002998501</td><td>0.01049475</td><td>0.007496252</td><td>0.004497751</td><td>0</td><td>0.02848576</td><td>0.01649175</td><td>0.02098951</td><td>0.01049475</td><td>0.008995502</td><td>0.004497751</td><td>0.1649175</td><td>0.3223388</td><td>0</td><td>0</td><td>0.017991</td><td>0.06446777</td><td>0.05247376</td><td>0.01049475</td><td>0</td><td>0.011994</td><td>0.02248876</td><td>0.008995502</td><td>0.00149925</td><td>0.005997001</td><td>0.01349325</td><td>0.5112444</td><td>0.03448276</td><td>0.2713643</td><td>0.03298351</td><td>0</td><td>0.1604198</td><td>0.03898051</td><td>0.02098951</td><td>0.06146927</td><td>0.06596702</td><td>0.002998501</td><td>0.1064468</td><td>0.3328336</td><td>0.007496252</td><td>0.02248876</td><td>0.06896552</td><td>0</td><td>0.017991</td><td>0.011994</td><td>0.0149925</td><td>0.007496252</td><td>0</td><td>0.004497751</td><td>0.07496252</td><td>0</td><td>0</td><td>0.002998501</td><td>0.04947526</td><td>0.06146927</td><td>0.1604198</td><td>0.04647676</td><td>0.004497751</td><td>0.08095952</td><td>0.06146927</td><td>0.09145427</td><td>0.011994</td><td>0.004497751</td><td>0.03148426</td><td>0.01049475</td><td>0.0149925</td><td>0.06596702</td><td>0</td><td>0.011994</td><td>0.02548726</td><td>0</td><td>0</td><td>0.2788606</td><td>0.011994</td><td>0.0149925</td><td>0</td><td>0.02998501</td><td>0</td><td>0.004497751</td><td>0.03898051</td><td>0.06596702</td><td>0</td><td>0.05847076</td><td>0.2068966</td><td>0.09745127</td><td>0.3568216</td><td>0.06746627</td><td>0.005997001</td><td>0.004497751</td><td>0.02398801</td><td>0.01049475</td><td>0.1244378</td><td>0.03448276</td><td>0.00149925</td><td>0.03448276</td><td>0.007496252</td><td>0.01049475</td><td>0.02398801</td><td>0.4257871</td><td>0.02098951</td><td>0.01649175</td><td>0.004497751</td><td>0.03748126</td><td>0.4107946</td><td>0.2473763</td><td>0.004497751</td><td>0.07496252</td><td>0.1064468</td><td>0.0149925</td><td>0.01949025</td><td>0.002998501</td><td>0</td><td>0.01649175</td><td>0.002998501</td><td>0.02848576</td><td>0</td><td>0.01649175</td><td>0.00149925</td><td>0.6926537</td><td>0.06296852</td><td>0.04647676</td><td>0.02098951</td><td>0.02548726</td><td>0.01349325</td><td>0.06296852</td><td>0</td><td>0.005997001</td><td>0.01649175</td><td>0.017991</td><td>0.002998501</td><td>0.011994</td><td>0.002998501</td><td>0.01949025</td><td>0.03448276</td><td>0</td><td>0.004497751</td><td>0.02398801</td><td>0.017991</td><td>0.1829085</td><td>0.02698651</td><td>0.00149925</td><td>0.04797601</td><td>0.01049475</td><td>0</td><td>0.01049475</td><td>0.09295352</td><td>0.01949025</td><td>0.01049475</td><td>0.00149925</td><td>0.01949025</td><td>0.01049475</td><td>0.008995502</td><td>0.07346327</td><td>0.4587706</td><td>0.017991</td><td>0.011994</td><td>0.01649175</td><td>0</td><td>0</td><td>0</td><td>0.1034483</td><td>0.007496252</td><td>0</td><td>0.06596702</td><td>0.00149925</td><td>0.00149925</td><td>0.005997001</td><td>0</td><td>0.1304348</td><td>0.0149925</td><td>0.07646177</td><td>0.1064468</td><td>0.06146927</td><td>0.01049475</td><td>0.1814093</td><td>0.005997001</td><td>0.08245877</td><td>0.05397301</td><td>0.1514243</td><td>0.1034483</td><td>0.04497751</td><td>0.03448276</td><td>0.008995502</td><td>0.04047976</td><td>0.017991</td><td>0.02698651</td><td>0.02998501</td><td>0.005997001</td></tr>
	<tr><th scope=row>10</th><td>italian</td><td>0.1172493</td><td>0.001531003</td><td>0.03393723</td><td>0.02143404</td><td>0.004337841</td><td>0.003189589</td><td>0.03023731</td><td>0.0294718</td><td>0.03891299</td><td>0.04746109</td><td>0.2558051</td><td>0.0349579</td><td>0.06149528</td><td>0.0001275836</td><td>0.07438122</td><td>0.09249809</td><td>0.3155142</td><td>0.01046185</td><td>0.05179893</td><td>0.1122735</td><td>0.07017096</td><td>0.02449604</td><td>0.1287318</td><td>0.01773412</td><td>0.2117887</td><td>0.006124011</td><td>0.006124011</td><td>0.005741261</td><td>0.03967849</td><td>0.001148252</td><td>0.05537127</td><td>0.008292932</td><td>0.05460577</td><td>0.01479969</td><td>0.7454708</td><td>0.02857872</td><td>0.2341158</td><td>0.005230926</td><td>0.005230926</td><td>0.01365144</td><td>0.0003827507</td><td>0.00357234</td><td>0.0007655014</td><td>0.0163307</td><td>0.02679255</td><td>0.2010717</td><td>0.003189589</td><td>0.006634345</td><td>0.01607553</td><td>0.2507017</td><td>0.01990304</td><td>0.002934422</td><td>0.008165348</td><td>0.006506762</td><td>0.01212044</td><td>0.1044909</td><td>0.002551671</td><td>0.02781322</td><td>0.009951518</td><td>0.01492728</td><td>0.1268181</td><td>0.05090584</td><td>0.01696861</td><td>0.1120184</td><td>0.005103343</td><td>0.004720592</td><td>0.001148252</td><td>0.004720592</td><td>0.06545037</td><td>0.01365144</td><td>0.003062006</td><td>0.02845114</td><td>0.01658586</td><td>0.3716509</td><td>0.2287573</td><td>0.02908905</td><td>0</td><td>0.1737688</td><td>0.04146466</td><td>0.04848176</td><td>0.03227864</td><td>0.01377903</td><td>0.02755805</td><td>0.03368206</td><td>0.002041337</td><td>0.003955091</td><td>0.06825721</td><td>0.07616739</td><td>0.1736412</td><td>0.03151314</td><td>0.6368972</td><td>0.04325083</td><td>0.0001275836</td><td>0.5324062</td><td>0.00535851</td><td>0.00893085</td><td>0.01454453</td><td>0.2649911</td><td>0.001148252</td><td>0.09645318</td><td>0.3803266</td><td>0.03023731</td><td>0.01237561</td><td>0.048099</td><td>0</td><td>0.01671345</td><td>0.03176831</td><td>0.00714468</td><td>0.1437867</td><td>0.004848176</td><td>0.002551671</td><td>0.1237561</td><td>0.01990304</td><td>0.003955091</td><td>0.00178617</td><td>0.08497066</td><td>0.004593008</td><td>0.1647104</td><td>0.09300842</td><td>0.02079612</td><td>0.1560347</td><td>0.01352386</td><td>0.1787446</td><td>0.02258229</td><td>0.009441184</td><td>0.01046185</td><td>0.006379178</td><td>0.04159224</td><td>0.02411329</td><td>0.0001275836</td><td>0.008037765</td><td>0.009823935</td><td>0.01173769</td><td>0.0002551671</td><td>0.09402909</td><td>0.04950242</td><td>0.02156162</td><td>0</td><td>0.01237561</td><td>0.002806838</td><td>0.1593519</td><td>0.1075529</td><td>0.01875478</td><td>0.04006124</td><td>0.03023731</td><td>0.6612656</td><td>0.6362592</td><td>0.3466446</td><td>0.03687165</td><td>0.125925</td><td>0.001148252</td><td>0.01135494</td><td>0.3133452</td><td>0.2227609</td><td>0.05741261</td><td>0.1294973</td><td>0.0264098</td><td>0.0006379178</td><td>0.005486093</td><td>0.03406481</td><td>0.7231437</td><td>0.004848176</td><td>0.004337841</td><td>0.04848176</td><td>0.0294718</td><td>0.0364889</td><td>0.09224292</td><td>0.04478183</td><td>0.0108446</td><td>0.2619291</td><td>0.01569278</td><td>0.02181679</td><td>0.04682317</td><td>0.08484307</td><td>0.02985455</td><td>0.0007655014</td><td>0.06481245</td><td>0.004720592</td><td>0.03534065</td><td>0.001658586</td><td>0.6247767</td><td>0.1710896</td><td>0.07501914</td><td>0.008037765</td><td>0.04337841</td><td>0.07119163</td><td>0.02283746</td><td>0.000893085</td><td>0.002168921</td><td>0.04031641</td><td>0.004848176</td><td>0.0163307</td><td>0.009951518</td><td>0.008420515</td><td>0.003189589</td><td>0.07540189</td><td>0.03164072</td><td>0.0442715</td><td>0.05600919</td><td>0.008165348</td><td>0.009186017</td><td>0.05294718</td><td>0.01020669</td><td>0.01428936</td><td>0.002934422</td><td>0.04554733</td><td>0.07323297</td><td>0.08254657</td><td>0.02079612</td><td>0.0006379178</td><td>0.0186272</td><td>0.01097219</td><td>0.01237561</td><td>0.003827507</td><td>0.03444756</td><td>0.1758102</td><td>0.02538913</td><td>0.002041337</td><td>0.004465425</td><td>0</td><td>0.0002551671</td><td>0.008292932</td><td>0.06685379</td><td>0.008037765</td><td>0.002168921</td><td>0.4268946</td><td>0.002168921</td><td>0.0007655014</td><td>0.02373054</td><td>0.0002551671</td><td>0.07399847</td><td>0.01186527</td><td>0.04159224</td><td>0.06902271</td><td>0.09874968</td><td>0.02334779</td><td>0.1892064</td><td>0.008037765</td><td>0.02207196</td><td>0.03559582</td><td>0.2181679</td><td>0.05754019</td><td>0.1940546</td><td>0.007655014</td><td>0.03164072</td><td>0.04669559</td><td>0.004337841</td><td>0.02883389</td><td>0.03470273</td><td>0.04337841</td></tr>
	<tr><th scope=row>11</th><td>jamaican</td><td>0.07984791</td><td>0.3707224</td><td>0.005703422</td><td>0.01140684</td><td>0.01520913</td><td>0.01140684</td><td>0.01330798</td><td>0.01901141</td><td>0.09315589</td><td>0.001901141</td><td>0.01520913</td><td>0.03992395</td><td>0.1140684</td><td>0</td><td>0.1121673</td><td>0.1406844</td><td>0.4220532</td><td>0.01140684</td><td>0.06653992</td><td>0.06653992</td><td>0.07794677</td><td>0.001901141</td><td>0.05513308</td><td>0.2072243</td><td>0.1749049</td><td>0.003802281</td><td>0.01901141</td><td>0.01901141</td><td>0.001901141</td><td>0.003802281</td><td>0.09315589</td><td>0.09505703</td><td>0.03041825</td><td>0.003802281</td><td>0.03231939</td><td>0.007604563</td><td>0.338403</td><td>0</td><td>0.1121673</td><td>0.108365</td><td>0.009505703</td><td>0.007604563</td><td>0.005703422</td><td>0.01330798</td><td>0.007604563</td><td>0.1330798</td><td>0.03231939</td><td>0.06463878</td><td>0.2414449</td><td>0.2756654</td><td>0.01140684</td><td>0.2661597</td><td>0.0608365</td><td>0.01901141</td><td>0.001901141</td><td>0.08745247</td><td>0.03802281</td><td>0.04562738</td><td>0.02471483</td><td>0.009505703</td><td>0.04562738</td><td>0.05893536</td><td>0</td><td>0.03041825</td><td>0.001901141</td><td>0.05703422</td><td>0.1444867</td><td>0.08365019</td><td>0.03041825</td><td>0.01140684</td><td>0.003802281</td><td>0.01330798</td><td>0.001901141</td><td>0.3098859</td><td>0.1235741</td><td>0.001901141</td><td>0</td><td>0.01140684</td><td>0.04372624</td><td>0.02091255</td><td>0</td><td>0</td><td>0.02091255</td><td>0.02091255</td><td>0</td><td>0.02471483</td><td>0.06463878</td><td>0.005703422</td><td>0.2110266</td><td>0.009505703</td><td>0.4296578</td><td>0.01140684</td><td>0.003802281</td><td>0.595057</td><td>0.2357414</td><td>0.001901141</td><td>0.02281369</td><td>0.0608365</td><td>0.001901141</td><td>0.2072243</td><td>1.030418</td><td>0.02471483</td><td>0.009505703</td><td>0.003802281</td><td>0</td><td>0.01520913</td><td>0.1197719</td><td>0.01901141</td><td>0.001901141</td><td>0</td><td>0.05703422</td><td>0.2585551</td><td>0</td><td>0.001901141</td><td>0.06273764</td><td>0.06273764</td><td>0.001901141</td><td>0.04562738</td><td>0.01711027</td><td>0.01711027</td><td>0.1121673</td><td>0.001901141</td><td>0.04372624</td><td>0.001901141</td><td>0.01140684</td><td>0.04942966</td><td>0.2908745</td><td>0.03231939</td><td>0.003802281</td><td>0.005703422</td><td>0.01711027</td><td>0.03231939</td><td>0.007604563</td><td>0</td><td>0.2775665</td><td>0.05893536</td><td>0.003802281</td><td>0</td><td>0.01711027</td><td>0</td><td>0.007604563</td><td>0.009505703</td><td>0.03231939</td><td>0.005703422</td><td>0.2281369</td><td>0.513308</td><td>0.1387833</td><td>0.7110266</td><td>0.08935361</td><td>0.01330798</td><td>0.001901141</td><td>0.05323194</td><td>0.003802281</td><td>0.02851711</td><td>0.03041825</td><td>0.001901141</td><td>0.03612167</td><td>0.01520913</td><td>0.01520913</td><td>0.02661597</td><td>1.171103</td><td>0.01901141</td><td>0.02091255</td><td>0.009505703</td><td>0.0608365</td><td>0.1007605</td><td>0.3840304</td><td>0.04942966</td><td>0.02091255</td><td>0.2338403</td><td>0.003802281</td><td>0.005703422</td><td>0.1273764</td><td>0</td><td>0.01711027</td><td>0.03041825</td><td>0.01140684</td><td>0</td><td>0.01520913</td><td>0.003802281</td><td>0.7965779</td><td>0.3288973</td><td>0</td><td>0.2148289</td><td>0.03992395</td><td>0.09885932</td><td>0.03612167</td><td>0.009505703</td><td>0.003802281</td><td>0.01711027</td><td>0</td><td>0.001901141</td><td>0.007604563</td><td>0</td><td>0.001901141</td><td>0.01330798</td><td>0.03802281</td><td>0.0608365</td><td>0.02851711</td><td>0.01140684</td><td>0.02661597</td><td>0.03231939</td><td>0.003802281</td><td>0.01711027</td><td>0.1539924</td><td>0</td><td>0.02661597</td><td>0.03041825</td><td>0.02091255</td><td>0.01520913</td><td>0.01140684</td><td>0.02091255</td><td>0.01711027</td><td>0.01330798</td><td>0.07224335</td><td>0.3878327</td><td>0.0513308</td><td>0.02281369</td><td>0.01520913</td><td>0</td><td>0</td><td>0.03231939</td><td>0.5627376</td><td>0.005703422</td><td>0</td><td>0.161597</td><td>0.009505703</td><td>0.02851711</td><td>0.005703422</td><td>0.02471483</td><td>0.03612167</td><td>0.03041825</td><td>0.07034221</td><td>0.230038</td><td>0.1711027</td><td>0.009505703</td><td>0.3992395</td><td>0.009505703</td><td>0.003802281</td><td>0.005703422</td><td>0.1730038</td><td>0.01901141</td><td>0.04562738</td><td>0.01901141</td><td>0.02281369</td><td>0.06653992</td><td>0.003802281</td><td>0.003802281</td><td>0.01330798</td><td>0.009505703</td></tr>
	<tr><th scope=row>12</th><td>japanese</td><td>0.04848911</td><td>0.0007027407</td><td>0.009135629</td><td>0.003513703</td><td>0.01264933</td><td>0.04216444</td><td>0.02670415</td><td>0.005621926</td><td>0.03865074</td><td>0.002810963</td><td>0.007027407</td><td>0.01686578</td><td>0.03583978</td><td>0.0154603</td><td>0.04989459</td><td>0.03583978</td><td>0.1082221</td><td>0.01335207</td><td>0.0639494</td><td>0.00983837</td><td>0.04567814</td><td>0.01194659</td><td>0.04708363</td><td>0.08081518</td><td>0.07378777</td><td>0</td><td>0.07378777</td><td>0.04427266</td><td>0</td><td>0.02670415</td><td>0.1433591</td><td>0.01827126</td><td>0.01335207</td><td>0.0007027407</td><td>0.02459592</td><td>0.006324666</td><td>0.1939564</td><td>0.002108222</td><td>0.01967674</td><td>0.1278988</td><td>0.01194659</td><td>0.0007027407</td><td>0.0007027407</td><td>0.02600141</td><td>0.005621926</td><td>0.05200281</td><td>0.005621926</td><td>0.06535488</td><td>0.01616304</td><td>0.08151792</td><td>0.006324666</td><td>0.03021785</td><td>0.0224877</td><td>0.005621926</td><td>0.002810963</td><td>0.05059733</td><td>0.04567814</td><td>0.08011244</td><td>0</td><td>0.004919185</td><td>0.04286718</td><td>0.002810963</td><td>0</td><td>0.0154603</td><td>0.08151792</td><td>0.04567814</td><td>0.02529866</td><td>0.037948</td><td>0.004216444</td><td>0.009135629</td><td>0.003513703</td><td>0.004216444</td><td>0.004919185</td><td>0.08995081</td><td>0.2347154</td><td>0.02740689</td><td>0</td><td>0.0154603</td><td>0.01616304</td><td>0.008432888</td><td>0.008432888</td><td>0</td><td>0.07238229</td><td>0.01475755</td><td>0.04778637</td><td>0.018974</td><td>0.08432888</td><td>0.004216444</td><td>0.1426564</td><td>0.01054111</td><td>0.2839072</td><td>0.03092059</td><td>0.03232607</td><td>0.2515812</td><td>0.3239635</td><td>0.002108222</td><td>0.03373155</td><td>0.01335207</td><td>0.0007027407</td><td>0.2319044</td><td>0.1834153</td><td>0.005621926</td><td>0.002810963</td><td>0.01054111</td><td>0.006324666</td><td>0.05551651</td><td>0.02810963</td><td>0.00983837</td><td>0.001405481</td><td>0.0007027407</td><td>0.003513703</td><td>0.1004919</td><td>0</td><td>0.003513703</td><td>0.02600141</td><td>0.056922</td><td>0</td><td>0.08713985</td><td>0.01264933</td><td>0.001405481</td><td>0.07800422</td><td>0.01335207</td><td>0.0983837</td><td>0.002108222</td><td>0.007730148</td><td>0.03373155</td><td>0.0449754</td><td>0.05551651</td><td>0.0007027407</td><td>0.03583978</td><td>0.03583978</td><td>0.01967674</td><td>0.01335207</td><td>0</td><td>0.07167955</td><td>0.03443429</td><td>0.003513703</td><td>0.2825018</td><td>0.01054111</td><td>0</td><td>0.002810963</td><td>0.1033029</td><td>0.03373155</td><td>0.09557273</td><td>0.002108222</td><td>0.6331694</td><td>0.056922</td><td>0.3316936</td><td>0.02529866</td><td>0</td><td>0.009135629</td><td>0.006324666</td><td>0.005621926</td><td>0.007730148</td><td>0.1293043</td><td>0.002108222</td><td>0.05270555</td><td>0.0224877</td><td>0.002810963</td><td>0.04075896</td><td>0.2740689</td><td>0.007027407</td><td>0.01124385</td><td>0.005621926</td><td>0.07870696</td><td>0.06746311</td><td>0.1658468</td><td>0.00983837</td><td>0.002810963</td><td>0.1257906</td><td>0.02389318</td><td>0.009135629</td><td>0.3893183</td><td>0.0007027407</td><td>0.01194659</td><td>0.03583978</td><td>0</td><td>0.004919185</td><td>0</td><td>0</td><td>0.4082923</td><td>0.6605762</td><td>0.001405481</td><td>0.1658468</td><td>0.05270555</td><td>0.01686578</td><td>0.2431483</td><td>0.001405481</td><td>0.3654252</td><td>0.02108222</td><td>0.0007027407</td><td>0.005621926</td><td>0.01054111</td><td>0.09697822</td><td>0.006324666</td><td>0.01967674</td><td>0.04989459</td><td>0.04567814</td><td>0.02881237</td><td>0.0154603</td><td>0.01405481</td><td>0.08011244</td><td>0.008432888</td><td>0.002108222</td><td>0.547435</td><td>0.001405481</td><td>0.05130007</td><td>0.018974</td><td>0.002810963</td><td>0.02951511</td><td>0.007027407</td><td>0.07800422</td><td>0.03513703</td><td>0.007027407</td><td>0.0449754</td><td>0.4567814</td><td>0.02881237</td><td>0.007027407</td><td>0.007027407</td><td>0</td><td>0.004919185</td><td>0.04567814</td><td>0.002108222</td><td>0.09627547</td><td>0.08924807</td><td>0.05481377</td><td>0.0007027407</td><td>0.02037948</td><td>0.002108222</td><td>0.02389318</td><td>0.01475755</td><td>0</td><td>0.01405481</td><td>0.2052003</td><td>0.2368236</td><td>0.007730148</td><td>0.3366128</td><td>0.01405481</td><td>0.01124385</td><td>0.001405481</td><td>0.2108222</td><td>0.01756852</td><td>0.04567814</td><td>0.0154603</td><td>0.004919185</td><td>0.03373155</td><td>0.002810963</td><td>0.03443429</td><td>0.00983837</td><td>0.01264933</td></tr>
	<tr><th scope=row>13</th><td>korean</td><td>0.0373494</td><td>0</td><td>0.001204819</td><td>0</td><td>0.03253012</td><td>0.002409639</td><td>0.02650602</td><td>0.009638554</td><td>0.01204819</td><td>0.004819277</td><td>0.002409639</td><td>0.003614458</td><td>0.07710843</td><td>0.03855422</td><td>0.2</td><td>0.0373494</td><td>0.2313253</td><td>0.004819277</td><td>0.0313253</td><td>0.003614458</td><td>0.01204819</td><td>0.004819277</td><td>0.04457831</td><td>0.2024096</td><td>0.01807229</td><td>0.002409639</td><td>0.1325301</td><td>0.05542169</td><td>0</td><td>0</td><td>0.2168675</td><td>0.01927711</td><td>0.006024096</td><td>0.007228916</td><td>0.01566265</td><td>0</td><td>0.1313253</td><td>0.001204819</td><td>0.09277108</td><td>0.1951807</td><td>0.02409639</td><td>0.002409639</td><td>0</td><td>0.0253012</td><td>0</td><td>0.05421687</td><td>0.01445783</td><td>0.02048193</td><td>0.007228916</td><td>0.2180723</td><td>0.01927711</td><td>0.009638554</td><td>0.02409639</td><td>0</td><td>0</td><td>0.08795181</td><td>0.007228916</td><td>0.07951807</td><td>0</td><td>0.003614458</td><td>0.007228916</td><td>0.001204819</td><td>0</td><td>0.05662651</td><td>0.09759036</td><td>0.001204819</td><td>0.002409639</td><td>0.08313253</td><td>0.001204819</td><td>0.003614458</td><td>0</td><td>0.001204819</td><td>0.003614458</td><td>0.05421687</td><td>0.2048193</td><td>0.004819277</td><td>0</td><td>0.004819277</td><td>0.007228916</td><td>0.004819277</td><td>0</td><td>0</td><td>0.009638554</td><td>0.002409639</td><td>0.04216867</td><td>0.07108434</td><td>0.1795181</td><td>0.004819277</td><td>0.1060241</td><td>0.004819277</td><td>0.2240964</td><td>0.003614458</td><td>0</td><td>0.7698795</td><td>0.3855422</td><td>0.004819277</td><td>0.02891566</td><td>0.001204819</td><td>0.001204819</td><td>0.4192771</td><td>0.2301205</td><td>0.001204819</td><td>0.003614458</td><td>0.003614458</td><td>0.004819277</td><td>0.09638554</td><td>0.04819277</td><td>0.008433735</td><td>0</td><td>0.001204819</td><td>0.01927711</td><td>0.07590361</td><td>0</td><td>0.001204819</td><td>0.01566265</td><td>0.08915663</td><td>0.007228916</td><td>0.0626506</td><td>0.01204819</td><td>0.01325301</td><td>0.04698795</td><td>0.01084337</td><td>0.02409639</td><td>0.002409639</td><td>0.05542169</td><td>0.04337349</td><td>0.01325301</td><td>0.06024096</td><td>0</td><td>0</td><td>0.01084337</td><td>0.02048193</td><td>0.01204819</td><td>0</td><td>0.007228916</td><td>0.1349398</td><td>0</td><td>0.07108434</td><td>0.008433735</td><td>0</td><td>0.001204819</td><td>0.1072289</td><td>0.01566265</td><td>0.06746988</td><td>0</td><td>0.9819277</td><td>0.05060241</td><td>0.753012</td><td>0.009638554</td><td>0</td><td>0.02409639</td><td>0.01325301</td><td>0</td><td>0.003614458</td><td>0.1156627</td><td>0.002409639</td><td>0.01084337</td><td>0.02289157</td><td>0</td><td>0.0253012</td><td>0.6963855</td><td>0.002409639</td><td>0.004819277</td><td>0.002409639</td><td>0.1084337</td><td>0.0626506</td><td>0.07710843</td><td>0.009638554</td><td>0.002409639</td><td>0.2855422</td><td>0.02650602</td><td>0.1096386</td><td>0.4987952</td><td>0</td><td>0.02891566</td><td>0.01927711</td><td>0.001204819</td><td>0</td><td>0</td><td>0.001204819</td><td>0.460241</td><td>0.8144578</td><td>0.004819277</td><td>0.2373494</td><td>0.04337349</td><td>0.01204819</td><td>0.4433735</td><td>0.004819277</td><td>1.080723</td><td>0.008433735</td><td>0.001204819</td><td>0.001204819</td><td>0.01445783</td><td>0.09277108</td><td>0.01084337</td><td>0.02409639</td><td>0.0373494</td><td>0.01325301</td><td>0.02891566</td><td>0.003614458</td><td>0.01084337</td><td>0.1012048</td><td>0</td><td>0.003614458</td><td>0.6554217</td><td>0.001204819</td><td>0.07831325</td><td>0.01807229</td><td>0</td><td>0.05542169</td><td>0.004819277</td><td>0.05662651</td><td>0.1024096</td><td>0.004819277</td><td>0.03975904</td><td>0.5879518</td><td>0.05301205</td><td>0</td><td>0.05542169</td><td>0</td><td>0.006024096</td><td>0.01566265</td><td>0.001204819</td><td>0.2301205</td><td>0.08072289</td><td>0.008433735</td><td>0.01204819</td><td>0</td><td>0.006024096</td><td>0</td><td>0.004819277</td><td>0</td><td>0.004819277</td><td>0.1626506</td><td>0.260241</td><td>0.004819277</td><td>0.3349398</td><td>0</td><td>0.006024096</td><td>0</td><td>0.1783133</td><td>0.006024096</td><td>0.1012048</td><td>0.001204819</td><td>0.002409639</td><td>0.04819277</td><td>0.001204819</td><td>0.01204819</td><td>0.003614458</td><td>0.06506024</td></tr>
	<tr><th scope=row>14</th><td>mexican</td><td>0.05125815</td><td>0.01025163</td><td>0.0128922</td><td>0.01335819</td><td>0.01429015</td><td>0.1713265</td><td>0.006679093</td><td>0.0195713</td><td>0.0397639</td><td>0.003727866</td><td>0.009785648</td><td>0.02920162</td><td>0.2656104</td><td>0</td><td>0.13032</td><td>0.1441441</td><td>0.3487108</td><td>0.00621311</td><td>0.09443927</td><td>0.01693072</td><td>0.1324946</td><td>0.002485244</td><td>0.1332712</td><td>0.0408512</td><td>0.08962411</td><td>0.004659832</td><td>0.02982293</td><td>0.04147251</td><td>0.004193849</td><td>0.0003106555</td><td>0.02625039</td><td>0.06601429</td><td>0.01724138</td><td>0.176297</td><td>0.4622554</td><td>0.01413482</td><td>0.3841255</td><td>0.002485244</td><td>0.2314383</td><td>0.472041</td><td>0</td><td>0.06896552</td><td>0.07844051</td><td>0.003727866</td><td>0.02003728</td><td>0.3226157</td><td>0.02236719</td><td>0.4339857</td><td>0.04954955</td><td>0.1814228</td><td>0.02625039</td><td>0.008387698</td><td>0.005747126</td><td>0.02143523</td><td>0.003106555</td><td>0.1116806</td><td>0.03386145</td><td>0.3342653</td><td>0.006523765</td><td>0.007611059</td><td>0.296676</td><td>0.007145076</td><td>0.006057782</td><td>0.0240758</td><td>0.01056229</td><td>0.3201305</td><td>0.0009319664</td><td>0.007300404</td><td>0.1251942</td><td>0.002951227</td><td>0.002485244</td><td>0.007455732</td><td>0.01926064</td><td>0.1296987</td><td>0.1015843</td><td>0.000621311</td><td>0.0621311</td><td>0.03199751</td><td>0.01615409</td><td>0.0453557</td><td>0.0009319664</td><td>0.006523765</td><td>0.01786269</td><td>0.02236719</td><td>0.002795899</td><td>0.003727866</td><td>0.02081392</td><td>0.004038521</td><td>0.221342</td><td>0.01879466</td><td>0.4168997</td><td>0.05529668</td><td>0</td><td>0.500466</td><td>0.004970488</td><td>0.003106555</td><td>0.01196024</td><td>0.02547375</td><td>0.01025163</td><td>0.3022678</td><td>0.5428705</td><td>0.02795899</td><td>0.004193849</td><td>0.01102827</td><td>0.0001553277</td><td>0.01863933</td><td>0.0537434</td><td>0.01273687</td><td>0.006368437</td><td>0.1326499</td><td>0.1825101</td><td>0.2528736</td><td>0.000621311</td><td>0.06523765</td><td>0.005747126</td><td>0.09583722</td><td>0.001708605</td><td>0.06197577</td><td>0.01755203</td><td>0.03292948</td><td>0.08993476</td><td>0.0004659832</td><td>0.03681267</td><td>0.01164958</td><td>0.07906182</td><td>0.01832867</td><td>0.3550792</td><td>0.03028891</td><td>0.01724138</td><td>0</td><td>0.02578441</td><td>0.01926064</td><td>0.009009009</td><td>0.07766387</td><td>0.06974216</td><td>0.0425598</td><td>0.007766387</td><td>0.0001553277</td><td>0.05327742</td><td>0.0823237</td><td>0.01475614</td><td>0.02345449</td><td>0.007766387</td><td>0.003727866</td><td>0.002329916</td><td>0.462566</td><td>0.286735</td><td>0.6890339</td><td>0.04395775</td><td>0.1407269</td><td>0.000621311</td><td>0.05638397</td><td>0.007921715</td><td>0.02283318</td><td>0.02811432</td><td>0.01227089</td><td>0.004970488</td><td>0.007145076</td><td>0.004193849</td><td>0.01025163</td><td>0.7283318</td><td>0.008543026</td><td>0.01102827</td><td>0.02951227</td><td>0.06150979</td><td>0.03572538</td><td>0.3690587</td><td>0.09599254</td><td>0.01133893</td><td>0.1825101</td><td>0.02935694</td><td>0.007455732</td><td>0.08077043</td><td>0.002485244</td><td>0.03836595</td><td>0.000621311</td><td>0.002485244</td><td>0.001087294</td><td>0.001087294</td><td>0.1992855</td><td>0.6088847</td><td>0.2342342</td><td>0.01491146</td><td>0.02671637</td><td>0.03091022</td><td>0.1040696</td><td>0.04411308</td><td>0.03665735</td><td>0.009319664</td><td>0.007145076</td><td>0.02593973</td><td>0.01910531</td><td>0.002795899</td><td>0.001708605</td><td>0.018484</td><td>0.2261572</td><td>0.02764834</td><td>0.07564461</td><td>0.0509475</td><td>0.02609506</td><td>0.005902454</td><td>0.04551103</td><td>0.03199751</td><td>0.2054986</td><td>0.009474992</td><td>0.002640572</td><td>0.01693072</td><td>0.05607331</td><td>0.01739671</td><td>0.002329916</td><td>0.0100963</td><td>0.009164337</td><td>0.02640572</td><td>0.01087294</td><td>0.03852128</td><td>0.1071761</td><td>0.03510407</td><td>0.007921715</td><td>0.003261883</td><td>0.09894377</td><td>0</td><td>0.01444548</td><td>0.01056229</td><td>0.003727866</td><td>0.002019261</td><td>0.44548</td><td>0.3937558</td><td>0.0007766387</td><td>0.02811432</td><td>0.001553277</td><td>0.02485244</td><td>0.01040696</td><td>0.02329916</td><td>0.1548618</td><td>0.06756757</td><td>0.008698354</td><td>0.1707052</td><td>0.0397639</td><td>0.01770736</td><td>0.0111836</td><td>0.1567257</td><td>0.055452</td><td>0.02485244</td><td>0.01040696</td><td>0.005125815</td><td>0.06927617</td><td>0.01786269</td><td>0.006834421</td><td>0.01071761</td><td>0.02283318</td></tr>
	<tr><th scope=row>15</th><td>moroccan</td><td>0.05359318</td><td>0.05359318</td><td>0.135201</td><td>0.007308161</td><td>0.008526188</td><td>0.002436054</td><td>0.01461632</td><td>0</td><td>0.01339829</td><td>0.006090134</td><td>0.01096224</td><td>0.02801462</td><td>0.07064555</td><td>0</td><td>0.08282582</td><td>0.09378806</td><td>0.3386114</td><td>0.02192448</td><td>0.0682095</td><td>0.02436054</td><td>0.07917174</td><td>0.004872107</td><td>0.2192448</td><td>0.02801462</td><td>0.1339829</td><td>0</td><td>0.004872107</td><td>0.02436054</td><td>0.009744214</td><td>0.03532278</td><td>0.2034105</td><td>0.1729598</td><td>0.04384896</td><td>0.002436054</td><td>0.02923264</td><td>0.01461632</td><td>0.4445798</td><td>0.1607795</td><td>0.02801462</td><td>0.05237515</td><td>0</td><td>0.002436054</td><td>0</td><td>0.002436054</td><td>0</td><td>0.408039</td><td>0.004872107</td><td>0.3483557</td><td>0.5030451</td><td>0.36419</td><td>0.02801462</td><td>0.008526188</td><td>0.001218027</td><td>0.001218027</td><td>0.01096224</td><td>0.05968331</td><td>0.3069428</td><td>0.01096224</td><td>0.00365408</td><td>0.009744214</td><td>0.007308161</td><td>0.008526188</td><td>0.008526188</td><td>0.04384896</td><td>0.009744214</td><td>0.5505481</td><td>0.02801462</td><td>0.001218027</td><td>0.07917174</td><td>0.00365408</td><td>0.007308161</td><td>0.008526188</td><td>0.001218027</td><td>0.2216809</td><td>0.09013398</td><td>0.04263094</td><td>0</td><td>0.1559074</td><td>0.00365408</td><td>0.04872107</td><td>0.03045067</td><td>0.01461632</td><td>0.03288672</td><td>0.03045067</td><td>0.001218027</td><td>0.007308161</td><td>0.04141291</td><td>0.08038977</td><td>0.1096224</td><td>0.03410475</td><td>0.8233861</td><td>0.01096224</td><td>0.007308161</td><td>0.5481121</td><td>0.3495737</td><td>0.06090134</td><td>0.01096224</td><td>0.05602923</td><td>0.02436054</td><td>0.1729598</td><td>1.668697</td><td>0.05237515</td><td>0</td><td>0.001218027</td><td>0</td><td>0.1425091</td><td>0.02557856</td><td>0.002436054</td><td>0.007308161</td><td>0</td><td>0.002436054</td><td>0.3154689</td><td>0.02801462</td><td>0</td><td>0.002436054</td><td>0.1157125</td><td>0.2070646</td><td>0.07673569</td><td>0.09622412</td><td>0.00365408</td><td>0.1169306</td><td>0.004872107</td><td>0.546894</td><td>0.03532278</td><td>0.006090134</td><td>0.004872107</td><td>0.02436054</td><td>0.0499391</td><td>0.006090134</td><td>0.007308161</td><td>0.008526188</td><td>0.01705238</td><td>0.002436054</td><td>0</td><td>0.02436054</td><td>0.04141291</td><td>0.1437272</td><td>0</td><td>0.009744214</td><td>0</td><td>0.001218027</td><td>0.007308161</td><td>0.01096224</td><td>0.006090134</td><td>0.03897686</td><td>0.7771011</td><td>0.8014616</td><td>0.6041413</td><td>0.1084044</td><td>0.01461632</td><td>0.001218027</td><td>0.2959805</td><td>0.00365408</td><td>0.2947625</td><td>0.09744214</td><td>0.006090134</td><td>0.0182704</td><td>0.004872107</td><td>0</td><td>0.0499391</td><td>0.8343484</td><td>0.009744214</td><td>0.02070646</td><td>0.02801462</td><td>0.007308161</td><td>0.09500609</td><td>0.09378806</td><td>0.0816078</td><td>0.1181486</td><td>0.226553</td><td>0.008526188</td><td>0.02070646</td><td>0.02314251</td><td>0.002436054</td><td>0.02192448</td><td>0.009744214</td><td>0.007308161</td><td>0.1534714</td><td>0</td><td>0.001218027</td><td>0.7320341</td><td>0.03045067</td><td>0.01339829</td><td>0.006090134</td><td>0.05115713</td><td>0.007308161</td><td>0.1705238</td><td>0.002436054</td><td>0.02436054</td><td>0.0365408</td><td>0</td><td>0.006090134</td><td>0.01218027</td><td>0</td><td>0.04019488</td><td>0.001218027</td><td>0.009744214</td><td>0.06211937</td><td>0.03897686</td><td>0.03775883</td><td>0</td><td>0.07186358</td><td>0.001218027</td><td>0.004872107</td><td>0.004872107</td><td>0.002436054</td><td>0.01461632</td><td>0.05237515</td><td>0.03532278</td><td>0.002436054</td><td>0.05359318</td><td>0</td><td>0.01583435</td><td>0.08769793</td><td>0.1254568</td><td>0.1583435</td><td>0.1266748</td><td>0</td><td>0.00365408</td><td>0</td><td>0</td><td>0.06333739</td><td>0.02679659</td><td>0.01705238</td><td>0.001218027</td><td>0.3751523</td><td>0</td><td>0.136419</td><td>0.009744214</td><td>0.08891596</td><td>0.05724726</td><td>0.001218027</td><td>0.007308161</td><td>0.1437272</td><td>0.0499391</td><td>0.02436054</td><td>0.3081608</td><td>0.02070646</td><td>0.01461632</td><td>0.002436054</td><td>0.08038977</td><td>0.03410475</td><td>0.06211937</td><td>0</td><td>0.02436054</td><td>0.08038977</td><td>0.04141291</td><td>0.009744214</td><td>0.03897686</td><td>0.04872107</td></tr>
	<tr><th scope=row>16</th><td>russian</td><td>0.2515337</td><td>0.01635992</td><td>0.05316973</td><td>0.008179959</td><td>0.06339468</td><td>0.00408998</td><td>0</td><td>0.02249489</td><td>0.1513292</td><td>0.008179959</td><td>0.01226994</td><td>0.0797546</td><td>0.03680982</td><td>0</td><td>0.1472393</td><td>0.03680982</td><td>0.2167689</td><td>0.02862986</td><td>0.01431493</td><td>0.08384458</td><td>0.02658487</td><td>0</td><td>0.08588957</td><td>0.03067485</td><td>0.4355828</td><td>0.02453988</td><td>0.1431493</td><td>0.01840491</td><td>0.0204499</td><td>0.01226994</td><td>0.1635992</td><td>0.01840491</td><td>0.08179959</td><td>0.008179959</td><td>0.1390593</td><td>0.01840491</td><td>0.08793456</td><td>0.00204499</td><td>0.00408998</td><td>0.01840491</td><td>0</td><td>0.00204499</td><td>0</td><td>0.02862986</td><td>0.03476483</td><td>0.1206544</td><td>0.02862986</td><td>0.01840491</td><td>0.06952965</td><td>0.1411043</td><td>0.02249489</td><td>0.00204499</td><td>0.03885481</td><td>0.0204499</td><td>0.02658487</td><td>0.03067485</td><td>0.01226994</td><td>0.03271984</td><td>0.00204499</td><td>0.008179959</td><td>0.3742331</td><td>0.04907975</td><td>0</td><td>0.00204499</td><td>0.0408998</td><td>0.01022495</td><td>0</td><td>0.0204499</td><td>0.02249489</td><td>0.01840491</td><td>0.2269939</td><td>0.008179959</td><td>0.00408998</td><td>0.1860941</td><td>0.5725971</td><td>0.00408998</td><td>0</td><td>0.01226994</td><td>0.08997955</td><td>0.008179959</td><td>0.01226994</td><td>0.00408998</td><td>0.03476483</td><td>0.02658487</td><td>0</td><td>0.008179959</td><td>0.01226994</td><td>0.02249489</td><td>0.4846626</td><td>0</td><td>0.3271984</td><td>0.0204499</td><td>0</td><td>0.1799591</td><td>0.01840491</td><td>0.03271984</td><td>0.03885481</td><td>0.0204499</td><td>0.00408998</td><td>0.1042945</td><td>0.3251534</td><td>0.01226994</td><td>0.02658487</td><td>0.03680982</td><td>0</td><td>0.04498978</td><td>0.03476483</td><td>0.008179959</td><td>0.00408998</td><td>0</td><td>0.00408998</td><td>0.1308793</td><td>0.00204499</td><td>0</td><td>0.01840491</td><td>0.04703476</td><td>0.006134969</td><td>0.2474438</td><td>0.04703476</td><td>0.01635992</td><td>0.0797546</td><td>0.01840491</td><td>0.206544</td><td>0</td><td>0.00408998</td><td>0.01635992</td><td>0</td><td>0.008179959</td><td>0.01431493</td><td>0.00408998</td><td>0.06339468</td><td>0.02249489</td><td>0.00408998</td><td>0</td><td>0.200409</td><td>0.0204499</td><td>0.008179959</td><td>0</td><td>0.01022495</td><td>0</td><td>0.008179959</td><td>0.09611452</td><td>0.03476483</td><td>0.01635992</td><td>0.01635992</td><td>0.3537832</td><td>0.1349693</td><td>0.4274029</td><td>0.02862986</td><td>0.00408998</td><td>0</td><td>0.0408998</td><td>0.00408998</td><td>0.1206544</td><td>0.03885481</td><td>0.00204499</td><td>0.0408998</td><td>0</td><td>0</td><td>0.02862986</td><td>0.4355828</td><td>0.02453988</td><td>0.03067485</td><td>0.008179959</td><td>0.05316973</td><td>0.2617587</td><td>0.1676892</td><td>0.01635992</td><td>0.08179959</td><td>0.1165644</td><td>0.01022495</td><td>0.03271984</td><td>0.0408998</td><td>0.006134969</td><td>0.008179959</td><td>0.01840491</td><td>0.006134969</td><td>0.008179959</td><td>0.00204499</td><td>0</td><td>0.7055215</td><td>0.06543967</td><td>0.0204499</td><td>0.01840491</td><td>0.02862986</td><td>0.01431493</td><td>0.08793456</td><td>0</td><td>0</td><td>0.01840491</td><td>0.00204499</td><td>0</td><td>0.00408998</td><td>0.00408998</td><td>0.00408998</td><td>0.01840491</td><td>0.008179959</td><td>0.01431493</td><td>0.03067485</td><td>0.03067485</td><td>0.04907975</td><td>0.01635992</td><td>0.01431493</td><td>0.2597137</td><td>0.006134969</td><td>0</td><td>0.008179959</td><td>0.01226994</td><td>0.00408998</td><td>0</td><td>0</td><td>0.02862986</td><td>0.01840491</td><td>0.01635992</td><td>0.0408998</td><td>0.5132924</td><td>0.03680982</td><td>0.006134969</td><td>0.01226994</td><td>0</td><td>0</td><td>0.00204499</td><td>0.02249489</td><td>0.01022495</td><td>0.00408998</td><td>0.1676892</td><td>0.00204499</td><td>0.00204499</td><td>0.01226994</td><td>0</td><td>0.192229</td><td>0.01431493</td><td>0.1288344</td><td>0.1860941</td><td>0.1513292</td><td>0.04498978</td><td>0.3415133</td><td>0.00408998</td><td>0.01635992</td><td>0.03680982</td><td>0.194274</td><td>0.05725971</td><td>0.07770961</td><td>0.01226994</td><td>0.1165644</td><td>0.01840491</td><td>0.02658487</td><td>0.07361963</td><td>0.0204499</td><td>0.00408998</td></tr>
	<tr><th scope=row>17</th><td>southern_us</td><td>0.2831019</td><td>0.01365741</td><td>0.0162037</td><td>0.01412037</td><td>0.0537037</td><td>0.003009259</td><td>0.01111111</td><td>0.09976852</td><td>0.287037</td><td>0.007175926</td><td>0.01898148</td><td>0.04444444</td><td>0.03634259</td><td>0</td><td>0.01990741</td><td>0.07013889</td><td>0.200463</td><td>0.0150463</td><td>0.03009259</td><td>0.05972222</td><td>0.03356481</td><td>0.003009259</td><td>0.09027778</td><td>0.1451389</td><td>0.4944444</td><td>0.1648148</td><td>0.01481481</td><td>0.02662037</td><td>0.001851852</td><td>0.002083333</td><td>0.0349537</td><td>0.07662037</td><td>0.08101852</td><td>0.09328704</td><td>0.2018519</td><td>0.01111111</td><td>0.2134259</td><td>0.000462963</td><td>0.01574074</td><td>0.05069444</td><td>0</td><td>0.006944444</td><td>0.005324074</td><td>0.0212963</td><td>0.02592593</td><td>0.1738426</td><td>0.05277778</td><td>0.01342593</td><td>0.09236111</td><td>0.09166667</td><td>0.01689815</td><td>0.02800926</td><td>0.01550926</td><td>0.02662037</td><td>0.0150463</td><td>0.07199074</td><td>0.003703704</td><td>0.1918981</td><td>0.07361111</td><td>0.01342593</td><td>0.2233796</td><td>0.03888889</td><td>0.003703704</td><td>0.03564815</td><td>0.005787037</td><td>0.01736111</td><td>0.006481481</td><td>0.03912037</td><td>0.03171296</td><td>0.02337963</td><td>0.01018519</td><td>0.004861111</td><td>0.0150463</td><td>0.1159722</td><td>0.3907407</td><td>0.0006944444</td><td>0.0002314815</td><td>0.02268519</td><td>0.1368056</td><td>0.0275463</td><td>0.003009259</td><td>0.0009259259</td><td>0.01689815</td><td>0.02268519</td><td>0.01782407</td><td>0.00162037</td><td>0.03842593</td><td>0.01087963</td><td>0.4275463</td><td>0.01643519</td><td>0.2375</td><td>0.03888889</td><td>0.000462963</td><td>0.2284722</td><td>0.02685185</td><td>0.009490741</td><td>0.06689815</td><td>0.05347222</td><td>0.003240741</td><td>0.1826389</td><td>0.3546296</td><td>0.02962963</td><td>0.05162037</td><td>0.05902778</td><td>0.000462963</td><td>0.04074074</td><td>0.07685185</td><td>0.03518519</td><td>0.01203704</td><td>0.01064815</td><td>0.02546296</td><td>0.1375</td><td>0.0006944444</td><td>0.02708333</td><td>0.02361111</td><td>0.08263889</td><td>0.0006944444</td><td>0.2162037</td><td>0.02638889</td><td>0.003240741</td><td>0.05</td><td>0.004166667</td><td>0.1356481</td><td>0.006712963</td><td>0.01273148</td><td>0.07152778</td><td>0.03912037</td><td>0.01851852</td><td>0.01782407</td><td>0.000462963</td><td>0.04212963</td><td>0.01296296</td><td>0.007638889</td><td>0.001157407</td><td>0.2585648</td><td>0.02453704</td><td>0.02523148</td><td>0</td><td>0.03796296</td><td>0.004398148</td><td>0.003009259</td><td>0.01782407</td><td>0.07777778</td><td>0.001157407</td><td>0.05115741</td><td>0.2953704</td><td>0.09930556</td><td>0.3159722</td><td>0.0474537</td><td>0.01273148</td><td>0.006481481</td><td>0.0625</td><td>0.03148148</td><td>0.0662037</td><td>0.008333333</td><td>0.004166667</td><td>0.04861111</td><td>0.04050926</td><td>0.09930556</td><td>0.008564815</td><td>0.6270833</td><td>0.00625</td><td>0.006944444</td><td>0.006712963</td><td>0.05115741</td><td>0.07268519</td><td>0.3273148</td><td>0.02199074</td><td>0.01111111</td><td>0.1293981</td><td>0.01319444</td><td>0.03101852</td><td>0.03564815</td><td>0.0002314815</td><td>0.02013889</td><td>0.00162037</td><td>0.0125</td><td>0.0002314815</td><td>0.01828704</td><td>0.004166667</td><td>0.7148148</td><td>0.1847222</td><td>0.03541667</td><td>0.01643519</td><td>0.02453704</td><td>0.08449074</td><td>0.02592593</td><td>0.0009259259</td><td>0.003240741</td><td>0.01481481</td><td>0.04907407</td><td>0.01180556</td><td>0.005787037</td><td>0.002314815</td><td>0.008101852</td><td>0.05115741</td><td>0.05023148</td><td>0.02268519</td><td>0.05231481</td><td>0.03587963</td><td>0.1094907</td><td>0.02337963</td><td>0.02060185</td><td>0.03171296</td><td>0.008101852</td><td>0.000462963</td><td>0.004861111</td><td>0.04768519</td><td>0.01736111</td><td>0.0002314815</td><td>0.008333333</td><td>0.03680556</td><td>0.01481481</td><td>0.006481481</td><td>0.02731481</td><td>0.5368056</td><td>0.07314815</td><td>0.02893519</td><td>0.06273148</td><td>0.000462963</td><td>0</td><td>0.01134259</td><td>0.0599537</td><td>0.006712963</td><td>0</td><td>0.1085648</td><td>0.002083333</td><td>0.002083333</td><td>0.01134259</td><td>0.002777778</td><td>0.1527778</td><td>0.01597222</td><td>0.1800926</td><td>0.1523148</td><td>0.10625</td><td>0.007175926</td><td>0.2071759</td><td>0.00625</td><td>0.01087963</td><td>0.05625</td><td>0.19375</td><td>0.07592593</td><td>0.03726852</td><td>0.04212963</td><td>0.009259259</td><td>0.08726852</td><td>0.008564815</td><td>0.0337963</td><td>0.02361111</td><td>0.003240741</td></tr>
	<tr><th scope=row>18</th><td>spanish</td><td>0.05358948</td><td>0.004044489</td><td>0.0950455</td><td>0.005055612</td><td>0.02426694</td><td>0.02325581</td><td>0.01617796</td><td>0.02426694</td><td>0.03336704</td><td>0.02426694</td><td>0.03538928</td><td>0.09403438</td><td>0.06471183</td><td>0</td><td>0.0364004</td><td>0.2679474</td><td>0.2537917</td><td>0.01921132</td><td>0.03336704</td><td>0.1183013</td><td>0.04246714</td><td>0.002022245</td><td>0.1344793</td><td>0.02224469</td><td>0.09302326</td><td>0.003033367</td><td>0.009100101</td><td>0.007077856</td><td>0.02022245</td><td>0.001011122</td><td>0.04550051</td><td>0.04044489</td><td>0.02426694</td><td>0.007077856</td><td>0.08897877</td><td>0.01415571</td><td>0.2649141</td><td>0.02325581</td><td>0.04853387</td><td>0.06875632</td><td>0</td><td>0.005055612</td><td>0.006066734</td><td>0.01617796</td><td>0.006066734</td><td>0.2264914</td><td>0.008088979</td><td>0.08695652</td><td>0.06875632</td><td>0.3852376</td><td>0.01617796</td><td>0.004044489</td><td>0.005055612</td><td>0.01617796</td><td>0.005055612</td><td>0.06673407</td><td>0.01112235</td><td>0.04145602</td><td>0.004044489</td><td>0.008088979</td><td>0.06875632</td><td>0.03538928</td><td>0.005055612</td><td>0.05662285</td><td>0.07886754</td><td>0.07077856</td><td>0.005055612</td><td>0.008088979</td><td>0.07482305</td><td>0.01213347</td><td>0.005055612</td><td>0.006066734</td><td>0.001011122</td><td>0.2780586</td><td>0.2770475</td><td>0.01314459</td><td>0</td><td>0.2578362</td><td>0.03538928</td><td>0.04044489</td><td>0.01718908</td><td>0.004044489</td><td>0.03235592</td><td>0.02325581</td><td>0.001011122</td><td>0.01617796</td><td>0.04448938</td><td>0.08291203</td><td>0.09908999</td><td>0.03235592</td><td>0.4924166</td><td>0.04651163</td><td>0</td><td>0.5672396</td><td>0.01112235</td><td>0.01314459</td><td>0.01011122</td><td>0.03943377</td><td>0.001011122</td><td>0.2608696</td><td>0.3650152</td><td>0.02123357</td><td>0.05358948</td><td>0.0182002</td><td>0</td><td>0.02527806</td><td>0.06066734</td><td>0.02628918</td><td>0.0182002</td><td>0.001011122</td><td>0.03134479</td><td>0.2457027</td><td>0.008088979</td><td>0.009100101</td><td>0.006066734</td><td>0.1233569</td><td>0.007077856</td><td>0.2537917</td><td>0.1314459</td><td>0.004044489</td><td>0.1051567</td><td>0.01112235</td><td>0.2163802</td><td>0.02527806</td><td>0.01314459</td><td>0.008088979</td><td>0.0677452</td><td>0.03741153</td><td>0.01718908</td><td>0</td><td>0.01516684</td><td>0.01213347</td><td>0.03235592</td><td>0.001011122</td><td>0.1081901</td><td>0.06268959</td><td>0.02527806</td><td>0</td><td>0.01112235</td><td>0.001011122</td><td>0.002022245</td><td>0.02426694</td><td>0.01617796</td><td>0.002022245</td><td>0.01617796</td><td>0.7421638</td><td>0.7371082</td><td>0.5217391</td><td>0.1425683</td><td>0.0677452</td><td>0.004044489</td><td>0.19818</td><td>0.01213347</td><td>0.247725</td><td>0.04246714</td><td>0.006066734</td><td>0.07280081</td><td>0</td><td>0.003033367</td><td>0.03033367</td><td>0.9201213</td><td>0.008088979</td><td>0.01011122</td><td>0.05257836</td><td>0.04448938</td><td>0.1678463</td><td>0.05358948</td><td>0.05561173</td><td>0.02831143</td><td>0.4115268</td><td>0.01011122</td><td>0.01415571</td><td>0.1365015</td><td>0.002022245</td><td>0.0586451</td><td>0</td><td>0.02325581</td><td>0.1274014</td><td>0.005055612</td><td>0.01314459</td><td>0.6845298</td><td>0.07785642</td><td>0.08998989</td><td>0.02426694</td><td>0.05257836</td><td>0.009100101</td><td>0.0182002</td><td>0.03336704</td><td>0.001011122</td><td>0.02932255</td><td>0.001011122</td><td>0.005055612</td><td>0.1284125</td><td>0.003033367</td><td>0.005055612</td><td>0.002022245</td><td>0.1223458</td><td>0.03134479</td><td>0.05561173</td><td>0.07583418</td><td>0.0182002</td><td>0.05662285</td><td>0.002022245</td><td>0.01921132</td><td>0.004044489</td><td>0.005055612</td><td>0.01921132</td><td>0.04954499</td><td>0.0273003</td><td>0</td><td>0.003033367</td><td>0.01718908</td><td>0.006066734</td><td>0.03437816</td><td>0.0586451</td><td>0.190091</td><td>0.06066734</td><td>0.01617796</td><td>0.007077856</td><td>0</td><td>0</td><td>0.03134479</td><td>0.07381193</td><td>0.004044489</td><td>0</td><td>0.4408493</td><td>0.008088979</td><td>0.009100101</td><td>0.0182002</td><td>0.003033367</td><td>0.04448938</td><td>0.003033367</td><td>0.04752275</td><td>0.08190091</td><td>0.2163802</td><td>0.008088979</td><td>0.2082912</td><td>0.02932255</td><td>0.004044489</td><td>0.01718908</td><td>0.2497472</td><td>0.03437816</td><td>0.273003</td><td>0.01415571</td><td>0.01213347</td><td>0.06471183</td><td>0.01112235</td><td>0.04145602</td><td>0.03336704</td><td>0.01921132</td></tr>
	<tr><th scope=row>19</th><td>thai</td><td>0.01104613</td><td>0.0006497726</td><td>0.005198181</td><td>0.004548408</td><td>0.01169591</td><td>0.009096816</td><td>0.03638726</td><td>0.0006497726</td><td>0.005198181</td><td>0.00259909</td><td>0.217024</td><td>0.009096816</td><td>0.08836907</td><td>0.09876543</td><td>0.03508772</td><td>0.165692</td><td>0.08252112</td><td>0.008447044</td><td>0.1500975</td><td>0.01039636</td><td>0.2033788</td><td>0.0259909</td><td>0.1325536</td><td>0.2202729</td><td>0.1481481</td><td>0.0006497726</td><td>0.0591293</td><td>0.05003249</td><td>0</td><td>0.01364522</td><td>0.1461988</td><td>0.03443795</td><td>0.01364522</td><td>0</td><td>0.007797271</td><td>0.02209227</td><td>0.4951267</td><td>0.005198181</td><td>0.1851852</td><td>0.3612736</td><td>0.02274204</td><td>0.0006497726</td><td>0</td><td>0.01494477</td><td>0</td><td>0.2306693</td><td>0.009746589</td><td>0.474334</td><td>0.01494477</td><td>0.2319688</td><td>0.007147498</td><td>0.482781</td><td>0.009096816</td><td>0.005847953</td><td>0</td><td>0.1156595</td><td>0.122807</td><td>0.07147498</td><td>0</td><td>0.003898635</td><td>0.02858999</td><td>0.005847953</td><td>0.0006497726</td><td>0.06887589</td><td>0.08122157</td><td>0.05717999</td><td>0.3118908</td><td>0.05588044</td><td>0.007797271</td><td>0.001299545</td><td>0</td><td>0.001299545</td><td>0.007147498</td><td>0.09681611</td><td>0.1358025</td><td>0.02339181</td><td>0</td><td>0.005847953</td><td>0.003898635</td><td>0.03443795</td><td>0.00259909</td><td>0.0006497726</td><td>0.03573749</td><td>0.004548408</td><td>0.05782976</td><td>0.5406108</td><td>0.08901884</td><td>0.0006497726</td><td>0.03508772</td><td>0.01559454</td><td>0.8609487</td><td>0.01819363</td><td>0.001299545</td><td>0.6218324</td><td>0.3385315</td><td>0.006497726</td><td>0.01949318</td><td>0.0214425</td><td>0.001299545</td><td>0.3736192</td><td>0.2527615</td><td>0.03573749</td><td>0</td><td>0.005198181</td><td>0.01104613</td><td>0.05198181</td><td>0.04288499</td><td>0.006497726</td><td>0.001299545</td><td>0.0006497726</td><td>0.0545809</td><td>0.3833658</td><td>0</td><td>0.00259909</td><td>0.01949318</td><td>0.0545809</td><td>0.001949318</td><td>0.09551657</td><td>0.01169591</td><td>0.007147498</td><td>0.3424301</td><td>0.004548408</td><td>0.09811566</td><td>0.01364522</td><td>0.05003249</td><td>0.1195582</td><td>0.7238467</td><td>0.06887589</td><td>0.005198181</td><td>0.001949318</td><td>0.006497726</td><td>0.009096816</td><td>0.04418454</td><td>0</td><td>0.4106563</td><td>0.07927225</td><td>0.1111111</td><td>0.004548408</td><td>0.007147498</td><td>0.0006497726</td><td>0.00259909</td><td>0.0877193</td><td>0.009096816</td><td>0.1676413</td><td>0.006497726</td><td>0.6868096</td><td>0.08122157</td><td>0.454191</td><td>0.02469136</td><td>0.00259909</td><td>0.02988954</td><td>0.01234568</td><td>0.001299545</td><td>0.005198181</td><td>0.3703704</td><td>0.003248863</td><td>0.05782976</td><td>0.4061079</td><td>0</td><td>0.07212476</td><td>0.6250812</td><td>0.02469136</td><td>0.003248863</td><td>0.007147498</td><td>0.05393112</td><td>0.03183886</td><td>0.1137102</td><td>0.0545809</td><td>0.003898635</td><td>0.539961</td><td>0.03768681</td><td>0.01104613</td><td>0.4243015</td><td>0</td><td>0.1189084</td><td>0.05328135</td><td>0</td><td>0.001299545</td><td>0.0006497726</td><td>0.001299545</td><td>0.380117</td><td>1.063028</td><td>0</td><td>0.08966862</td><td>0.03053931</td><td>0.01234568</td><td>0.08836907</td><td>0.03248863</td><td>0.1604938</td><td>0.1585445</td><td>0</td><td>0.004548408</td><td>0.005198181</td><td>0.0259909</td><td>0.00259909</td><td>0.03573749</td><td>0.1903834</td><td>0.14295</td><td>0.06497726</td><td>0.001299545</td><td>0.001949318</td><td>0.1098116</td><td>0.00259909</td><td>0</td><td>0.3287849</td><td>0.005847953</td><td>0.02404159</td><td>0.02988954</td><td>0.0214425</td><td>0.03833658</td><td>0.02079272</td><td>0.04873294</td><td>0.0474334</td><td>0.03118908</td><td>0.07732294</td><td>0.5620533</td><td>0.08317089</td><td>0.007797271</td><td>0.014295</td><td>0</td><td>0.3164392</td><td>0.0402859</td><td>0.00259909</td><td>0.03508772</td><td>0.06887589</td><td>0.09616634</td><td>0.009746589</td><td>0.02534113</td><td>0.01169591</td><td>0.02664068</td><td>0.03573749</td><td>0.07862248</td><td>0.001949318</td><td>0.2690058</td><td>0.151397</td><td>0.005847953</td><td>0.2475634</td><td>0.07407407</td><td>0.007797271</td><td>0.001949318</td><td>0.1312541</td><td>0.008447044</td><td>0.03183886</td><td>0.00259909</td><td>0.001299545</td><td>0.04418454</td><td>0.004548408</td><td>0.0006497726</td><td>0.03573749</td><td>0.02988954</td></tr>
	<tr><th scope=row>20</th><td>vietnamese</td><td>0.01454545</td><td>0.004848485</td><td>0.004848485</td><td>0.004848485</td><td>0.01333333</td><td>0.0169697</td><td>0.02424242</td><td>0.002424242</td><td>0.01090909</td><td>0.001212121</td><td>0.1963636</td><td>0.01090909</td><td>0.1018182</td><td>0.1539394</td><td>0.1333333</td><td>0.04848485</td><td>0.230303</td><td>0.006060606</td><td>0.08</td><td>0.01212121</td><td>0.08363636</td><td>0.01333333</td><td>0.09454545</td><td>0.12</td><td>0.07636364</td><td>0</td><td>0.07393939</td><td>0.1030303</td><td>0</td><td>0.01939394</td><td>0.3078788</td><td>0.01212121</td><td>0.01818182</td><td>0</td><td>0.002424242</td><td>0.002424242</td><td>0.2884848</td><td>0</td><td>0.2060606</td><td>0.3042424</td><td>0.04363636</td><td>0.001212121</td><td>0.001212121</td><td>0.01090909</td><td>0</td><td>0.1939394</td><td>0.01090909</td><td>0.4072727</td><td>0.06545455</td><td>0.2509091</td><td>0.01090909</td><td>0.07515152</td><td>0.01575758</td><td>0.02181818</td><td>0.001212121</td><td>0.08606061</td><td>0.1006061</td><td>0.07272727</td><td>0</td><td>0.01575758</td><td>0.008484848</td><td>0.002424242</td><td>0</td><td>0.04121212</td><td>0.1915152</td><td>0.01090909</td><td>0.03636364</td><td>0.04242424</td><td>0.00969697</td><td>0.001212121</td><td>0.007272727</td><td>0.001212121</td><td>0.006060606</td><td>0.08363636</td><td>0.1139394</td><td>0.007272727</td><td>0</td><td>0.006060606</td><td>0.004848485</td><td>0.0169697</td><td>0.01212121</td><td>0</td><td>0.0230303</td><td>0.008484848</td><td>0.04606061</td><td>0.5939394</td><td>0.04969697</td><td>0.001212121</td><td>0.07151515</td><td>0.006060606</td><td>0.6824242</td><td>0.008484848</td><td>0</td><td>0.6569697</td><td>0.2763636</td><td>0.004848485</td><td>0.02909091</td><td>0.01939394</td><td>0.001212121</td><td>0.2545455</td><td>0.3284848</td><td>0.008484848</td><td>0.006060606</td><td>0.002424242</td><td>0.07636364</td><td>0.04</td><td>0.07030303</td><td>0.01212121</td><td>0.003636364</td><td>0.001212121</td><td>0.07393939</td><td>0.3115152</td><td>0</td><td>0.002424242</td><td>0.007272727</td><td>0.1115152</td><td>0.002424242</td><td>0.0569697</td><td>0.02666667</td><td>0.003636364</td><td>0.3442424</td><td>0.004848485</td><td>0.07272727</td><td>0.007272727</td><td>0.1454545</td><td>0.04727273</td><td>0.4521212</td><td>0.03878788</td><td>0.002424242</td><td>0</td><td>0.04</td><td>0.03878788</td><td>0.05454545</td><td>0</td><td>0.07757576</td><td>0.1042424</td><td>0.2181818</td><td>0.007272727</td><td>0.00969697</td><td>0.001212121</td><td>0</td><td>0.05818182</td><td>0.003636364</td><td>0.2145455</td><td>0.002424242</td><td>0.64</td><td>0.05212121</td><td>0.5006061</td><td>0.0169697</td><td>0</td><td>0.03393939</td><td>0.007272727</td><td>0.001212121</td><td>0.006060606</td><td>0.07878788</td><td>0</td><td>0.02060606</td><td>0.2060606</td><td>0</td><td>0.04121212</td><td>0.6048485</td><td>0.03030303</td><td>0.002424242</td><td>0.007272727</td><td>0.2012121</td><td>0.01818182</td><td>0.09333333</td><td>0.05454545</td><td>0</td><td>0.2133333</td><td>0.02424242</td><td>0.01454545</td><td>0.5781818</td><td>0</td><td>0.09575758</td><td>0.03272727</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.4848485</td><td>1.140606</td><td>0.01333333</td><td>0.1212121</td><td>0.02424242</td><td>0.01333333</td><td>0.08242424</td><td>0.04484848</td><td>0.1781818</td><td>0.1915152</td><td>0</td><td>0.003636364</td><td>0.002424242</td><td>0.03272727</td><td>0.01939394</td><td>0.05333333</td><td>0.1636364</td><td>0.06060606</td><td>0.05333333</td><td>0</td><td>0.006060606</td><td>0.07878788</td><td>0.006060606</td><td>0.001212121</td><td>0.2860606</td><td>0.004848485</td><td>0.00969697</td><td>0.0230303</td><td>0.03757576</td><td>0.07636364</td><td>0.00969697</td><td>0.08</td><td>0.07878788</td><td>0.07636364</td><td>0.06181818</td><td>0.6618182</td><td>0.03151515</td><td>0.02424242</td><td>0.004848485</td><td>0</td><td>0.1624242</td><td>0.02181818</td><td>0</td><td>0.04484848</td><td>0.06666667</td><td>0.07030303</td><td>0.003636364</td><td>0.01575758</td><td>0.007272727</td><td>0.0230303</td><td>0.04</td><td>0.006060606</td><td>0.004848485</td><td>0.2072727</td><td>0.2363636</td><td>0.02909091</td><td>0.3612121</td><td>0.05212121</td><td>0.00969697</td><td>0</td><td>0.1709091</td><td>0.01333333</td><td>0.04</td><td>0.001212121</td><td>0.002424242</td><td>0.08363636</td><td>0.002424242</td><td>0.008484848</td><td>0.006060606</td><td>0.003636364</td></tr>
</tbody>
</table>





```R
ingredientsDTM_train_korea <- ingredientsDTM_train[ingredientsDTM_train$cuisine == "korean",]
```


```R
head(ingredientsDTM_train_korea)
```




<table>
<thead><tr><th></th><th scope=col>all-purpos</th><th scope=col>allspic</th><th scope=col>almond</th><th scope=col>and</th><th scope=col>appl</th><th scope=col>avocado</th><th scope=col>babi</th><th scope=col>bacon</th><th scope=col>bake</th><th scope=col>balsam</th><th scope=col>basil</th><th scope=col>bay</th><th scope=col>bean</th><th scope=col>beansprout</th><th scope=col>beef</th><th scope=col>bell</th><th scope=col>black</th><th scope=col>boil</th><th scope=col>boneless</th><th scope=col>bread</th><th scope=col>breast</th><th scope=col>broccoli</th><th scope=col>broth</th><th scope=col>brown</th><th scope=col>butter</th><th scope=col>buttermilk</th><th scope=col>cabbag</th><th scope=col>canola</th><th scope=col>caper</th><th scope=col>cardamom</th><th scope=col>carrot</th><th scope=col>cayenn</th><th scope=col>celeri</th><th scope=col>cheddar</th><th scope=col>chees</th><th scope=col>cherri</th><th scope=col>chicken</th><th scope=col>chickpea</th><th scope=col>chile</th><th scope=col>chili</th><th scope=col>chines</th><th scope=col>chip</th><th scope=col>chipotl</th><th scope=col>chive</th><th scope=col>chocol</th><th scope=col>chop</th><th scope=col>cider</th><th scope=col>cilantro</th><th scope=col>cinnamon</th><th scope=col>clove</th><th scope=col>coars</th><th scope=col>coconut</th><th scope=col>cold</th><th scope=col>condens</th><th scope=col>confection</th><th scope=col>cook</th><th scope=col>coriand</th><th scope=col>corn</th><th scope=col>cornmeal</th><th scope=col>crack</th><th scope=col>cream</th><th scope=col>crumb</th><th scope=col>crumbl</th><th scope=col>crush</th><th scope=col>cucumb</th><th scope=col>cumin</th><th scope=col>curri</th><th scope=col>dark</th><th scope=col>dice</th><th scope=col>dijon</th><th scope=col>dill</th><th scope=col>dough</th><th scope=col>dress</th><th scope=col>dri</th><th scope=col>egg</th><th scope=col>eggplant</th><th scope=col>enchilada</th><th scope=col>extra-virgin</th><th scope=col>extract</th><th scope=col>fat</th><th scope=col>fennel</th><th scope=col>feta</th><th scope=col>fillet</th><th scope=col>fine</th><th scope=col>firm</th><th scope=col>fish</th><th scope=col>flake</th><th scope=col>flat</th><th scope=col>flour</th><th scope=col>free</th><th scope=col>fresh</th><th scope=col>frozen</th><th scope=col>garam</th><th scope=col>garlic</th><th scope=col>ginger</th><th scope=col>golden</th><th scope=col>granul</th><th scope=col>grate</th><th scope=col>greek</th><th scope=col>green</th><th scope=col>ground</th><th scope=col>halv</th><th scope=col>ham</th><th scope=col>heavi</th><th scope=col>hoisin</th><th scope=col>honey</th><th scope=col>hot</th><th scope=col>ice</th><th scope=col>italian</th><th scope=col>jack</th><th scope=col>jalapeno</th><th scope=col>juic</th><th scope=col>kalamata</th><th scope=col>kernel</th><th scope=col>ketchup</th><th scope=col>kosher</th><th scope=col>lamb</th><th scope=col>larg</th><th scope=col>leaf</th><th scope=col>lean</th><th scope=col>leav</th><th scope=col>leek</th><th scope=col>lemon</th><th scope=col>less</th><th scope=col>lettuc</th><th scope=col>light</th><th scope=col>lime</th><th scope=col>low</th><th scope=col>low-fat</th><th scope=col>masala</th><th scope=col>mayonais</th><th scope=col>meat</th><th scope=col>medium</th><th scope=col>mexican</th><th scope=col>milk</th><th scope=col>minc</th><th scope=col>mint</th><th scope=col>mirin</th><th scope=col>mix</th><th scope=col>monterey</th><th scope=col>mozzarella</th><th scope=col>mushroom</th><th scope=col>mustard</th><th scope=col>noodl</th><th scope=col>nutmeg</th><th scope=col>oil</th><th scope=col>oliv</th><th scope=col>onion</th><th scope=col>orang</th><th scope=col>oregano</th><th scope=col>oyster</th><th scope=col>paprika</th><th scope=col>parmesan</th><th scope=col>parsley</th><th scope=col>past</th><th scope=col>pasta</th><th scope=col>pea</th><th scope=col>peanut</th><th scope=col>pecan</th><th scope=col>peel</th><th scope=col>pepper</th><th scope=col>peppercorn</th><th scope=col>plain</th><th scope=col>plum</th><th scope=col>pork</th><th scope=col>potato</th><th scope=col>powder</th><th scope=col>purpl</th><th scope=col>raisin</th><th scope=col>red</th><th scope=col>reduc</th><th scope=col>rib</th><th scope=col>rice</th><th scope=col>ricotta</th><th scope=col>roast</th><th scope=col>root</th><th scope=col>rosemari</th><th scope=col>saffron</th><th scope=col>sage</th><th scope=col>salsa</th><th scope=col>salt</th><th scope=col>sauc</th><th scope=col>sausag</th><th scope=col>scallion</th><th scope=col>sea</th><th scope=col>season</th><th scope=col>seed</th><th scope=col>serrano</th><th scope=col>sesam</th><th scope=col>shallot</th><th scope=col>sharp</th><th scope=col>shell</th><th scope=col>sherri</th><th scope=col>shiitak</th><th scope=col>shoulder</th><th scope=col>shred</th><th scope=col>shrimp</th><th scope=col>skinless</th><th scope=col>slice</th><th scope=col>smoke</th><th scope=col>soda</th><th scope=col>sodium</th><th scope=col>soup</th><th scope=col>sour</th><th scope=col>soy</th><th scope=col>spaghetti</th><th scope=col>spinach</th><th scope=col>spray</th><th scope=col>sprig</th><th scope=col>spring</th><th scope=col>squash</th><th scope=col>starch</th><th scope=col>steak</th><th scope=col>stick</th><th scope=col>stock</th><th scope=col>sugar</th><th scope=col>sweet</th><th scope=col>sweeten</th><th scope=col>syrup</th><th scope=col>taco</th><th scope=col>thai</th><th scope=col>thigh</th><th scope=col>thyme</th><th scope=col>toast</th><th scope=col>tofu</th><th scope=col>tomato</th><th scope=col>tortilla</th><th scope=col>tumer</th><th scope=col>turkey</th><th scope=col>turmer</th><th scope=col>unsalt</th><th scope=col>unsweeten</th><th scope=col>vanilla</th><th scope=col>veget</th><th scope=col>vinegar</th><th scope=col>warm</th><th scope=col>water</th><th scope=col>wedg</th><th scope=col>wheat</th><th scope=col>whip</th><th scope=col>white</th><th scope=col>whole</th><th scope=col>wine</th><th scope=col>worcestershir</th><th scope=col>yeast</th><th scope=col>yellow</th><th scope=col>yogurt</th><th scope=col>yolk</th><th scope=col>zest</th><th scope=col>zucchini</th><th scope=col>cuisine</th></tr></thead>
<tbody>
	<tr><th scope=row>67</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>korean</td></tr>
	<tr><th scope=row>89</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>korean</td></tr>
	<tr><th scope=row>105</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>korean</td></tr>
	<tr><th scope=row>110</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>korean</td></tr>
	<tr><th scope=row>141</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>korean</td></tr>
	<tr><th scope=row>158</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>korean</td></tr>
</tbody>
</table>





```R
ingredients_korea_sum <- apply(ingredientsDTM_train_korea[,-251], 2, sum)
ingredients_korea_mean <- apply(ingredientsDTM_train_korea[,-251], 2, mean)
```


```R
ingredients_korea_sum <- ingredients_korea_sum[order(ingredients_korea_sum, decreasing=T)]
ingredients_korea_mean <- ingredients_korea_mean[order(ingredients_korea_mean, decreasing=T)]
```


```R
barplot(ingredients_korea_sum[1:30], las=2)
```




```R
names(ingredients_korea_sum)
```




<ol class=list-inline>
	<li>"sesam"</li>
	<li>"oil"</li>
	<li>"sauc"</li>
	<li>"garlic"</li>
	<li>"onion"</li>
	<li>"pepper"</li>
	<li>"soy"</li>
	<li>"sugar"</li>
	<li>"rice"</li>
	<li>"salt"</li>
	<li>"seed"</li>
	<li>"green"</li>
	<li>"ginger"</li>
	<li>"water"</li>
	<li>"red"</li>
	<li>"vinegar"</li>
	<li>"scallion"</li>
	<li>"black"</li>
	<li>"ground"</li>
	<li>"toast"</li>
	<li>"fresh"</li>
	<li>"clove"</li>
	<li>"carrot"</li>
	<li>"egg"</li>
	<li>"brown"</li>
	<li>"beef"</li>
	<li>"chili"</li>
	<li>"flake"</li>
	<li>"white"</li>
	<li>"veget"</li>
	<li>"minc"</li>
	<li>"cabbag"</li>
	<li>"chicken"</li>
	<li>"past"</li>
	<li>"rib"</li>
	<li>"pork"</li>
	<li>"mushroom"</li>
	<li>"flour"</li>
	<li>"steak"</li>
	<li>"sodium"</li>
	<li>"wine"</li>
	<li>"cucumb"</li>
	<li>"honey"</li>
	<li>"chile"</li>
	<li>"shiitak"</li>
	<li>"kosher"</li>
	<li>"cook"</li>
	<li>"dark"</li>
	<li>"tofu"</li>
	<li>"corn"</li>
	<li>"spinach"</li>
	<li>"bean"</li>
	<li>"powder"</li>
	<li>"juic"</li>
	<li>"fish"</li>
	<li>"mirin"</li>
	<li>"noodl"</li>
	<li>"zucchini"</li>
	<li>"larg"</li>
	<li>"potato"</li>
	<li>"low"</li>
	<li>"crush"</li>
	<li>"starch"</li>
	<li>"canola"</li>
	<li>"lettuc"</li>
	<li>"spring"</li>
	<li>"syrup"</li>
	<li>"chop"</li>
	<li>"dri"</li>
	<li>"sweet"</li>
	<li>"oliv"</li>
	<li>"hot"</li>
	<li>"yellow"</li>
	<li>"leav"</li>
	<li>"broth"</li>
	<li>"light"</li>
	<li>"sea"</li>
	<li>"firm"</li>
	<li>"stock"</li>
	<li>"beansprout"</li>
	<li>"all-purpos"</li>
	<li>"bell"</li>
	<li>"shrimp"</li>
	<li>"appl"</li>
	<li>"boneless"</li>
	<li>"granul"</li>
	<li>"roast"</li>
	<li>"slice"</li>
	<li>"babi"</li>
	<li>"reduc"</li>
	<li>"chive"</li>
	<li>"peel"</li>
	<li>"chines"</li>
	<li>"cold"</li>
	<li>"lemon"</li>
	<li>"oyster"</li>
	<li>"shred"</li>
	<li>"peanut"</li>
	<li>"cilantro"</li>
	<li>"meat"</li>
	<li>"cayenn"</li>
	<li>"coars"</li>
	<li>"jalapeno"</li>
	<li>"root"</li>
	<li>"butter"</li>
	<li>"spray"</li>
	<li>"chees"</li>
	<li>"ketchup"</li>
	<li>"mustard"</li>
	<li>"thigh"</li>
	<li>"cider"</li>
	<li>"sherri"</li>
	<li>"lean"</li>
	<li>"lime"</li>
	<li>"paprika"</li>
	<li>"skinless"</li>
	<li>"bake"</li>
	<li>"breast"</li>
	<li>"leaf"</li>
	<li>"medium"</li>
	<li>"season"</li>
	<li>"tortilla"</li>
	<li>"yolk"</li>
	<li>"leek"</li>
	<li>"mayonais"</li>
	<li>"pea"</li>
	<li>"shoulder"</li>
	<li>"soda"</li>
	<li>"bacon"</li>
	<li>"coconut"</li>
	<li>"fillet"</li>
	<li>"orang"</li>
	<li>"purpl"</li>
	<li>"ice"</li>
	<li>"mix"</li>
	<li>"shallot"</li>
	<li>"tomato"</li>
	<li>"cheddar"</li>
	<li>"cinnamon"</li>
	<li>"coriand"</li>
	<li>"cream"</li>
	<li>"extract"</li>
	<li>"lamb"</li>
	<li>"milk"</li>
	<li>"celeri"</li>
	<li>"thai"</li>
	<li>"turkey"</li>
	<li>"wheat"</li>
	<li>"whole"</li>
	<li>"balsam"</li>
	<li>"boil"</li>
	<li>"broccoli"</li>
	<li>"eggplant"</li>
	<li>"extra-virgin"</li>
	<li>"fat"</li>
	<li>"flat"</li>
	<li>"free"</li>
	<li>"golden"</li>
	<li>"hoisin"</li>
	<li>"plain"</li>
	<li>"sausag"</li>
	<li>"serrano"</li>
	<li>"squash"</li>
	<li>"stick"</li>
	<li>"unsalt"</li>
	<li>"vanilla"</li>
	<li>"warm"</li>
	<li>"bay"</li>
	<li>"bread"</li>
	<li>"crack"</li>
	<li>"dijon"</li>
	<li>"dress"</li>
	<li>"frozen"</li>
	<li>"ham"</li>
	<li>"heavi"</li>
	<li>"parsley"</li>
	<li>"smoke"</li>
	<li>"sour"</li>
	<li>"zest"</li>
	<li>"avocado"</li>
	<li>"basil"</li>
	<li>"buttermilk"</li>
	<li>"chip"</li>
	<li>"curri"</li>
	<li>"fine"</li>
	<li>"less"</li>
	<li>"pasta"</li>
	<li>"peppercorn"</li>
	<li>"plum"</li>
	<li>"raisin"</li>
	<li>"yeast"</li>
	<li>"almond"</li>
	<li>"chickpea"</li>
	<li>"crumb"</li>
	<li>"cumin"</li>
	<li>"dice"</li>
	<li>"dough"</li>
	<li>"grate"</li>
	<li>"greek"</li>
	<li>"halv"</li>
	<li>"jack"</li>
	<li>"kernel"</li>
	<li>"mozzarella"</li>
	<li>"rosemari"</li>
	<li>"salsa"</li>
	<li>"sharp"</li>
	<li>"shell"</li>
	<li>"spaghetti"</li>
	<li>"thyme"</li>
	<li>"worcestershir"</li>
	<li>"yogurt"</li>
	<li>"allspic"</li>
	<li>"and"</li>
	<li>"caper"</li>
	<li>"cardamom"</li>
	<li>"cherri"</li>
	<li>"chipotl"</li>
	<li>"chocol"</li>
	<li>"condens"</li>
	<li>"confection"</li>
	<li>"cornmeal"</li>
	<li>"crumbl"</li>
	<li>"dill"</li>
	<li>"enchilada"</li>
	<li>"fennel"</li>
	<li>"feta"</li>
	<li>"garam"</li>
	<li>"italian"</li>
	<li>"kalamata"</li>
	<li>"low-fat"</li>
	<li>"masala"</li>
	<li>"mexican"</li>
	<li>"mint"</li>
	<li>"monterey"</li>
	<li>"nutmeg"</li>
	<li>"oregano"</li>
	<li>"parmesan"</li>
	<li>"pecan"</li>
	<li>"ricotta"</li>
	<li>"saffron"</li>
	<li>"sage"</li>
	<li>"soup"</li>
	<li>"sprig"</li>
	<li>"sweeten"</li>
	<li>"taco"</li>
	<li>"tumer"</li>
	<li>"turmer"</li>
	<li>"unsweeten"</li>
	<li>"wedg"</li>
	<li>"whip"</li>
</ol>




### 한국 재료
- "SESAM(참깨)" "기름" "sauc(소스)" "마늘", "양파" "고추" "콩" "설탕" "쌀", "소금" "씨" "녹색" "생강" "물" "빨간색" "식초" "scallion(파) ""땅 ""토스트 ""신선한 ""정향 ""당근 ""달걀 ""갈색 ""쇠고기 ""고추 ""찌 ""화이트 ""veget", "MINC ""cabbag ""닭 "" "블랙" 과거 ","갈비 ""돼지 고기 ","버섯 ","밀가루 ""스테이크 ""나트륨 ""와인 ""cucumb ""꿀 ""칠레 ""shiitak ""정결 한 ""요리 ""어두운 ""두부 ""옥수수 " "시금치" "콩" "분말"...


```R
barplot(ingredients_korea_mean[1:30], las=2)
```




```R
set.seed(2310)
```


```R
cartModelFit <- rpart(cuisine ~ ., data = train_data, method = "class")
```


```R
cartModelFit
```




    n= 23871 
    
    node), split, n, loss, yval, (yprob)
          * denotes terminal node
    
      1) root 23871 19168 italian (0.012 0.02 0.039 0.067 0.019 0.067 0.03 0.075 0.017 0.2 0.013 0.036 0.021 0.16 0.021 0.012 0.11 0.025 0.039 0.021)  
        2) tortilla< 0.5 22310 17617 italian (0.013 0.022 0.041 0.072 0.02 0.071 0.031 0.081 0.018 0.21 0.014 0.038 0.022 0.11 0.022 0.013 0.12 0.026 0.041 0.022)  
          4) parmesan>=0.5 1681   262 italian (0.0059 0.0024 0.022 0.0018 0 0.043 0.017 0.0012 0.0018 0.84 0.00059 0.0018 0 0.014 0.00059 0.0012 0.037 0.0042 0.00059 0.00059) *
          5) parmesan< 0.5 20629 17355 italian (0.013 0.023 0.043 0.077 0.022 0.073 0.033 0.087 0.019 0.16 0.015 0.041 0.024 0.11 0.024 0.014 0.12 0.028 0.045 0.024)  
           10) soy>=0.5 2724  1514 chinese (0.00073 0 0.0018 0.44 0.064 0.0018 0.0015 0.0088 0.0018 0.0037 0.016 0.16 0.12 0.0081 0.0011 0.00073 0.0059 0.00073 0.1 0.051) *
           11) soy< 0.5 17905 14641 italian (0.015 0.027 0.049 0.022 0.016 0.084 0.037 0.099 0.022 0.18 0.015 0.022 0.0089 0.13 0.027 0.016 0.14 0.032 0.036 0.02)  
             22) cumin< 0.5 15768 12521 italian (0.016 0.03 0.054 0.024 0.018 0.095 0.041 0.056 0.025 0.21 0.016 0.024 0.01 0.1 0.014 0.018 0.16 0.034 0.039 0.022)  
               44) oliv>=0.5 4407  2506 italian (0.016 0.0088 0.044 0.0045 0.0039 0.1 0.095 0.026 0.0082 0.43 0.007 0.0036 0.0014 0.077 0.025 0.0093 0.047 0.077 0.0079 0.0045) *
               45) oliv< 0.5 11361  9104 southern_us (0.016 0.038 0.058 0.032 0.023 0.093 0.02 0.068 0.031 0.12 0.02 0.031 0.014 0.11 0.0099 0.022 0.2 0.017 0.051 0.029)  
                 90) fish< 0.5 10644  8390 southern_us (0.016 0.04 0.061 0.032 0.02 0.099 0.021 0.072 0.033 0.13 0.02 0.033 0.013 0.12 0.011 0.023 0.21 0.018 0.02 0.011)  
                  180) cilantro< 0.5 9783  7545 southern_us (0.016 0.044 0.066 0.033 0.021 0.11 0.023 0.057 0.036 0.14 0.021 0.034 0.014 0.087 0.01 0.025 0.23 0.018 0.014 0.0085) *
                  181) cilantro>=0.5 861   451 mexican (0.02 0.0023 0.007 0.024 0.0023 0.0035 0.0012 0.24 0 0.013 0.0093 0.022 0.0023 0.48 0.016 0.0023 0.019 0.017 0.081 0.043) *
                 91) fish>=0.5 717   348 thai (0.007 0.0084 0.013 0.024 0.07 0.0042 0 0.011 0 0 0.013 0.0098 0.021 0.0028 0 0.0014 0.0042 0.0014 0.51 0.3) *
             23) cumin>=0.5 2137  1255 indian (0.008 0.0023 0.014 0.0014 0.00094 0.0047 0.013 0.41 0.00047 0.008 0.0061 0.014 0 0.33 0.13 0.00094 0.021 0.022 0.014 0.00094)  
               46) ginger>=0.5 701   164 indian (0.0043 0 0 0.0043 0 0.0014 0.0071 0.77 0 0.0014 0.0057 0.017 0 0.0057 0.16 0 0.0071 0.0014 0.023 0) *
               47) ginger< 0.5 1436   732 mexican (0.0097 0.0035 0.02 0 0.0014 0.0063 0.016 0.24 0.0007 0.011 0.0063 0.013 0 0.49 0.11 0.0014 0.027 0.032 0.0091 0.0014) *
        3) tortilla>=0.5 1561    57 mexican (0.00064 0 0.0032 0.0038 0.00064 0.00064 0.0019 0.0032 0 0.0064 0.0013 0.00064 0.0032 0.96 0 0.00064 0.0032 0.0032 0.0032 0.00064) *




```R
prp(cartModelFit)
```



~~~~
tortilla : 옥수수
paramesan : 치즈
soy : 대두
mirin : 미림 (일본 술의 한 종류, 조미료)
masala (향신료)
- Garam masala (from Hindi: गरम मसाला, garam ("hot") and masala (a mixture of spices)) is a blend of ground spices common in North Indian and other South Asian cuisines.[1] It is used alone or with other seasonings. The word garam refers to "heat" in the Ayurvedic sense of the word, meaning "to heat the body" as these spices, in the Ayurvedic system of medicine, elevate body temperature.
cilantro : 고수 (미나리과 살이풀)
oliv : 올리브
~~~~

## masala
![](https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Garammasalaphoto.jpg/250px-Garammasalaphoto.jpg)



```R
cartPredict <- predict(cartModelFit, newdata = vaild_data, type = "class")
```


```R
head(cartPredict)
```




<dl class=dl-horizontal>
	<dt>1</dt>
		<dd>italian</dd>
	<dt>2</dt>
		<dd>southern_us</dd>
	<dt>3</dt>
		<dd>chinese</dd>
	<dt>5</dt>
		<dd>mexican</dd>
	<dt>9</dt>
		<dd>mexican</dd>
	<dt>11</dt>
		<dd>italian</dd>
</dl>





```R
cartCM <- confusionMatrix(cartPredict, vaild_data$cuisine)
```


```R
cartCM
```




    Confusion Matrix and Statistics
    
                  Reference
    Prediction     brazilian british cajun_creole chinese filipino french greek
      brazilian            0       0            0       0        0      0     0
      british              0       0            0       0        0      0     0
      cajun_creole         0       0            0       0        0      0     0
      chinese              0       5            7     817      113      2     2
      filipino             0       0            0       0        0      0     0
      french               0       0            0       0        0      0     0
      greek                0       0            0       0        0      0     0
      indian               2       3            2       0        0      1     0
      irish                0       0            0       0        0      0     0
      italian             57      37          162      12       19    331   305
      jamaican             0       0            0       0        0      0     0
      japanese             0       0            0       0        0      0     0
      korean               0       0            0       0        0      0     0
      mexican             14       1           32      24        6      7    23
      moroccan             0       0            0       0        0      0     0
      russian              0       0            0       0        0      0     0
      southern_us        111     272          414     206      134    715   140
      spanish              0       0            0       0        0      0     0
      thai                 2       3            1      10       30      2     0
      vietnamese           0       0            0       0        0      0     0
                  Reference
    Prediction     indian irish italian jamaican japanese korean mexican moroccan
      brazilian         0     0       0        0        0      0       0        0
      british           0     0       0        0        0      0       0        0
      cajun_creole      0     0       0        0        0      0       0        0
      chinese           9     2       9       37      307    195      14        1
      filipino          0     0       0        0        0      0       0        0
      french            0     0       0        0        0      0       0        0
      greek             0     0       0        0        0      0       0        0
      indian          342     1       0        4       10      0       1       68
      irish             0     0       0        0        0      0       0        0
      italian          88    26    2225       20       20      8     251      101
      jamaican          0     0       0        0        0      0       0        0
      japanese          0     0       0        0        0      0       0        0
      korean            0     0       0        0        0      0       0        0
      mexican         364     4      25       15       23      5    1760      113
      moroccan          0     0       0        0        0      0       0        0
      russian           0     0       0        0        0      0       0        0
      southern_us     389   232     876      132      205     99     548       45
      spanish           0     0       0        0        0      0       0        0
      thai              9     1       0        2        4     25       1        0
      vietnamese        0     0       0        0        0      0       0        0
                  Reference
    Prediction     russian southern_us spanish thai vietnamese
      brazilian          0           0       0    0          0
      british            0           0       0    0          0
      cajun_creole       0           0       0    0          0
      chinese            1          19       2  208         90
      filipino           0           0       0    0          0
      french             0           0       0    0          0
      greek              0           0       0    0          0
      indian             0           2       0   12          0
      irish              0           0       0    0          0
      italian           20         227     246   32         11
      jamaican           0           0       0    0          0
      japanese           0           0       0    0          0
      korean             0           0       0    0          0
      mexican            4          40      32   71         25
      moroccan           0           0       0    0          0
      russian            0           0       0    0          0
      southern_us      170        1438     114   77         55
      spanish            0           0       0    0          0
      thai               0           2       1  215        149
      vietnamese         0           0       0    0          0
    
    Overall Statistics
                                              
                   Accuracy : 0.4274          
                     95% CI : (0.4197, 0.4351)
        No Information Rate : 0.1971          
        P-Value [Acc > NIR] : < 2.2e-16       
                                              
                      Kappa : 0.3396          
     Mcnemar's Test P-Value : NA              
    
    Statistics by Class:
    
                         Class: brazilian Class: british Class: cajun_creole
    Sensitivity                    0.0000        0.00000             0.00000
    Specificity                    1.0000        1.00000             1.00000
    Pos Pred Value                    NaN            NaN                 NaN
    Neg Pred Value                 0.9883        0.97982             0.96114
    Prevalence                     0.0117        0.02018             0.03886
    Detection Rate                 0.0000        0.00000             0.00000
    Detection Prevalence           0.0000        0.00000             0.00000
    Balanced Accuracy              0.5000        0.50000             0.50000
                         Class: chinese Class: filipino Class: french Class: greek
    Sensitivity                 0.76427         0.00000       0.00000      0.00000
    Specificity                 0.93104         1.00000       1.00000      1.00000
    Pos Pred Value              0.44402             NaN           NaN          NaN
    Neg Pred Value              0.98208         0.98101       0.93347      0.97045
    Prevalence                  0.06722         0.01899       0.06653      0.02955
    Detection Rate              0.05137         0.00000       0.00000      0.00000
    Detection Prevalence        0.11570         0.00000       0.00000      0.00000
    Balanced Accuracy           0.84765         0.50000       0.50000      0.50000
                         Class: indian Class: irish Class: italian Class: jamaican
    Sensitivity                0.28476      0.00000         0.7097         0.00000
    Specificity                0.99279      1.00000         0.8455         1.00000
    Pos Pred Value             0.76339          NaN         0.5300             NaN
    Neg Pred Value             0.94442      0.98327         0.9223         0.98679
    Prevalence                 0.07552      0.01673         0.1971         0.01321
    Detection Rate             0.02151      0.00000         0.1399         0.00000
    Detection Prevalence       0.02817      0.00000         0.2640         0.00000
    Balanced Accuracy          0.63878      0.50000         0.7776         0.50000
                         Class: japanese Class: korean Class: mexican
    Sensitivity                  0.00000       0.00000         0.6835
    Specificity                  1.00000       1.00000         0.9379
    Pos Pred Value                   NaN           NaN         0.6801
    Neg Pred Value               0.96422       0.97912         0.9388
    Prevalence                   0.03578       0.02088         0.1619
    Detection Rate               0.00000       0.00000         0.1107
    Detection Prevalence         0.00000       0.00000         0.1627
    Balanced Accuracy            0.50000       0.50000         0.8107
                         Class: moroccan Class: russian Class: southern_us
    Sensitivity                  0.00000        0.00000            0.83218
    Specificity                  1.00000        1.00000            0.65192
    Pos Pred Value                   NaN            NaN            0.22567
    Neg Pred Value               0.97937        0.98774            0.96957
    Prevalence                   0.02063        0.01226            0.10866
    Detection Rate               0.00000        0.00000            0.09042
    Detection Prevalence         0.00000        0.00000            0.40068
    Balanced Accuracy            0.50000        0.50000            0.74205
                         Class: spanish Class: thai Class: vietnamese
    Sensitivity                 0.00000     0.34959           0.00000
    Specificity                 1.00000     0.98417           1.00000
    Pos Pred Value                  NaN     0.47046               NaN
    Neg Pred Value              0.97516     0.97410           0.97925
    Prevalence                  0.02484     0.03867           0.02075
    Detection Rate              0.00000     0.01352           0.00000
    Detection Prevalence        0.00000     0.02874           0.00000
    Balanced Accuracy           0.50000     0.66688           0.50000




```R
install.packages("rJava", dependencies=T, repos='http://cran.rstudio.com/') 
```

    package 'rJava' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    


```R
install.packages("AUC", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("xgboost", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("RSofia", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("extraTrees", dependencies=T, repos='http://cran.rstudio.com/') 
```

    package 'AUC' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    

    also installing the dependencies 'jsonlite', 'stringi', 'rjson', 'htmlwidgets', 'rstudioapi', 'stringr', 'visNetwork', 'lmtest', 'DiagrammeR', 'Ckmeans.1d.dp', 'vcd'
    
    

    package 'jsonlite' successfully unpacked and MD5 sums checked
    

    Warning message:
    : cannot remove prior installation of package 'jsonlite'

    package 'stringi' successfully unpacked and MD5 sums checked
    package 'rjson' successfully unpacked and MD5 sums checked
    package 'htmlwidgets' successfully unpacked and MD5 sums checked
    package 'rstudioapi' successfully unpacked and MD5 sums checked
    package 'stringr' successfully unpacked and MD5 sums checked
    package 'visNetwork' successfully unpacked and MD5 sums checked
    package 'lmtest' successfully unpacked and MD5 sums checked
    package 'DiagrammeR' successfully unpacked and MD5 sums checked
    package 'Ckmeans.1d.dp' successfully unpacked and MD5 sums checked
    package 'vcd' successfully unpacked and MD5 sums checked
    package 'xgboost' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    

    also installing the dependency 'RUnit'
    
    

    package 'RUnit' successfully unpacked and MD5 sums checked
    package 'RSofia' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    package 'extraTrees' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    


```R
library(rJava)
library(extraTrees)
library(xgboost)
library(RSofia)
library(AUC)
```

    
    Attaching package: 'xgboost'
    
    The following object is masked from 'package:dplyr':
    
        slice
    
    Loading required package: Rcpp
    AUC 0.3.0
    Type AUCNews() to see the change log and ?AUC to get an overview.
    
    Attaching package: 'AUC'
    
    The following objects are masked from 'package:caret':
    
        sensitivity, specificity
    
    


```R
cartPredict <- predict(cartModelFit, newdata = vaild_data, type = "prob")
```


```R
head(cartPredict)
```




<dl class=dl-horizontal>
	<dt>1</dt>
		<dd>italian</dd>
	<dt>2</dt>
		<dd>southern_us</dd>
	<dt>3</dt>
		<dd>chinese</dd>
	<dt>5</dt>
		<dd>mexican</dd>
	<dt>9</dt>
		<dd>mexican</dd>
	<dt>11</dt>
		<dd>italian</dd>
</dl>





```R
install.packages("pROC", dependencies=T, repos='http://cran.rstudio.com/') 
```

    also installing the dependencies 'misc3d', 'rgl', 'multicool', 'ks', 'logcondens', 'doParallel'
    
    

    package 'misc3d' successfully unpacked and MD5 sums checked
    package 'rgl' successfully unpacked and MD5 sums checked
    package 'multicool' successfully unpacked and MD5 sums checked
    package 'ks' successfully unpacked and MD5 sums checked
    package 'logcondens' successfully unpacked and MD5 sums checked
    package 'doParallel' successfully unpacked and MD5 sums checked
    package 'pROC' successfully unpacked and MD5 sums checked
    
    The downloaded binary packages are in
    	C:\Users\syleeie\Rtmpm2OAra\downloaded_packages
    


```R
library(pROC)
```

    Type 'citation("pROC")' for a citation.
    
    Attaching package: 'pROC'
    
    The following objects are masked from 'package:AUC':
    
        auc, roc
    
    The following objects are masked from 'package:stats':
    
        cov, smooth, var
    
    


```R
str(vaild_data$cuisine)
```

     Factor w/ 20 levels "brazilian","british",..: 7 17 5 8 14 10 4 10 14 8 ...
    


```R
levels(vaild_data$cuisine)
```




<ol class=list-inline>
	<li>"brazilian"</li>
	<li>"british"</li>
	<li>"cajun_creole"</li>
	<li>"chinese"</li>
	<li>"filipino"</li>
	<li>"french"</li>
	<li>"greek"</li>
	<li>"indian"</li>
	<li>"irish"</li>
	<li>"italian"</li>
	<li>"jamaican"</li>
	<li>"japanese"</li>
	<li>"korean"</li>
	<li>"mexican"</li>
	<li>"moroccan"</li>
	<li>"russian"</li>
	<li>"southern_us"</li>
	<li>"spanish"</li>
	<li>"thai"</li>
	<li>"vietnamese"</li>
</ol>





```R
cartPredict_Prob <- apply(cartPredict, 1, which.max)
```


```R
head(cartPredict_Prob)
```




<dl class=dl-horizontal>
	<dt>1</dt>
		<dd>10</dd>
	<dt>2</dt>
		<dd>17</dd>
	<dt>3</dt>
		<dd>4</dd>
	<dt>5</dt>
		<dd>14</dd>
	<dt>9</dt>
		<dd>14</dd>
	<dt>11</dt>
		<dd>10</dd>
</dl>





```R
multiclass.roc(response=vaild_data$cuisine,  predictor=cartPredict_Prob, levels=levels(vaild_data$cuisine),percent=TRUE)
```




    
    Call:
    multiclass.roc.default(response = vaild_data$cuisine, predictor = cartPredict_Prob,     levels = levels(vaild_data$cuisine), percent = TRUE)
    
    Data: cartPredict_Prob with 20 levels of vaild_data$cuisine: brazilian, british, cajun_creole, chinese, filipino, french, greek, indian, irish, italian, jamaican, japanese, korean, mexican, moroccan, russian, southern_us, spanish, thai, vietnamese.
    Multi-class area under the curve: 64.41%




```R
cartPredict_test <- predict(cartModelFit, newdata = test_data, type = "class")
```


```R
head(cartPredict_test)
```




<dl class=dl-horizontal>
	<dt>39775</dt>
		<dd>southern_us</dd>
	<dt>39776</dt>
		<dd>southern_us</dd>
	<dt>39777</dt>
		<dd>italian</dd>
	<dt>39778</dt>
		<dd>southern_us</dd>
	<dt>39779</dt>
		<dd>italian</dd>
	<dt>39780</dt>
		<dd>southern_us</dd>
</dl>





```R
head(test$id)
```




<ol class=list-inline>
	<li>18009</li>
	<li>28583</li>
	<li>41580</li>
	<li>29752</li>
	<li>35687</li>
	<li>38527</li>
</ol>





```R
test_predict <- data.frame(id = test$id, cuisine = cartPredict_test)
```


```R
head(test_predict)
```




<table>
<thead><tr><th></th><th scope=col>id</th><th scope=col>cuisine</th></tr></thead>
<tbody>
	<tr><th scope=row>39775</th><td>18009</td><td>southern_us</td></tr>
	<tr><th scope=row>39776</th><td>28583</td><td>southern_us</td></tr>
	<tr><th scope=row>39777</th><td>41580</td><td>italian</td></tr>
	<tr><th scope=row>39778</th><td>29752</td><td>southern_us</td></tr>
	<tr><th scope=row>39779</th><td>35687</td><td>italian</td></tr>
	<tr><th scope=row>39780</th><td>38527</td><td>southern_us</td></tr>
</tbody>
</table>





```R
submission <- left_join(sample_sub, test_predict, by="id")
```


```R
head(submission)
```




<table>
<thead><tr><th></th><th scope=col>id</th><th scope=col>cuisine.x</th><th scope=col>cuisine.y</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>35203</td><td>italian</td><td>southern_us</td></tr>
	<tr><th scope=row>2</th><td>17600</td><td>italian</td><td>italian</td></tr>
	<tr><th scope=row>3</th><td>35200</td><td>italian</td><td>southern_us</td></tr>
	<tr><th scope=row>4</th><td>17602</td><td>italian</td><td>thai</td></tr>
	<tr><th scope=row>5</th><td>17605</td><td>italian</td><td>indian</td></tr>
	<tr><th scope=row>6</th><td>17604</td><td>italian</td><td>chinese</td></tr>
</tbody>
</table>





```R
submission <- submission[,-2]
```


```R
head(submission)
```




<table>
<thead><tr><th></th><th scope=col>id</th><th scope=col>cuisine.y</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>35203</td><td>southern_us</td></tr>
	<tr><th scope=row>2</th><td>17600</td><td>italian</td></tr>
	<tr><th scope=row>3</th><td>35200</td><td>southern_us</td></tr>
	<tr><th scope=row>4</th><td>17602</td><td>thai</td></tr>
	<tr><th scope=row>5</th><td>17605</td><td>indian</td></tr>
	<tr><th scope=row>6</th><td>17604</td><td>chinese</td></tr>
</tbody>
</table>





```R
colnames(submission) <- c("id", "cuisine")
```


```R
head(submission)
```




<table>
<thead><tr><th></th><th scope=col>id</th><th scope=col>cuisine</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>35203</td><td>southern_us</td></tr>
	<tr><th scope=row>2</th><td>17600</td><td>italian</td></tr>
	<tr><th scope=row>3</th><td>35200</td><td>southern_us</td></tr>
	<tr><th scope=row>4</th><td>17602</td><td>thai</td></tr>
	<tr><th scope=row>5</th><td>17605</td><td>indian</td></tr>
	<tr><th scope=row>6</th><td>17604</td><td>chinese</td></tr>
</tbody>
</table>





```R
write.csv(submission, file = 'cart_submission.csv', row.names = F)
```

### 첫번째 submission 결과
<img src="cart_submission.jpg" alt="alt text" title="Title"/>


```R
library(extraTrees)
```

### RandomForest 일종의 트리. 
- thresholds를 트리마다 랜덤하게 선택 (feautre를 나무마다 다르게 선택)
![](http://www.iis.ee.ic.ac.uk/icvl/iccv09_tutorial_files/random_forest_new2.png)
### http://scikit-learn.org/stable/modules/ensemble.html


```R
extraTreesModelFit <- extraTrees(train_data[,-251], train_data[,251], ntree=100, numThreads=4)
```


```R
extraTreesModelFit
```




    ExtraTrees:
     - # of trees: 100
     - node size:  1
     - # of dim:   250
     - # of tries: 15
     - type:       factor (classification)
     - multi-task: no




```R
vaild_label_extra <- predict(extraTreesModelFit, vaild_data[,-251], probability=T)
```


```R
head(vaild_label_extra) 
```




<table>
<thead><tr><th scope=col>brazilian</th><th scope=col>british</th><th scope=col>cajun_creole</th><th scope=col>chinese</th><th scope=col>filipino</th><th scope=col>french</th><th scope=col>greek</th><th scope=col>indian</th><th scope=col>irish</th><th scope=col>italian</th><th scope=col>jamaican</th><th scope=col>japanese</th><th scope=col>korean</th><th scope=col>mexican</th><th scope=col>moroccan</th><th scope=col>russian</th><th scope=col>southern_us</th><th scope=col>spanish</th><th scope=col>thai</th><th scope=col>vietnamese</th></tr></thead>
<tbody>
	<tr><td>0.00</td><td>0.00</td><td>0.04</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.73</td><td>0.01</td><td>0.00</td><td>0.17</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.04</td><td>0.00</td><td>0.00</td><td>0.01</td><td>0.00</td><td>0.00</td><td>0.00</td></tr>
	<tr><td>0.00</td><td>0.18</td><td>0.10</td><td>0.00</td><td>0.00</td><td>0.03</td><td>0.00</td><td>0.01</td><td>0.00</td><td>0.03</td><td>0.05</td><td>0.00</td><td>0.00</td><td>0.09</td><td>0.00</td><td>0.01</td><td>0.50</td><td>0.00</td><td>0.00</td><td>0.00</td></tr>
	<tr><td>0.01</td><td>0.00</td><td>0.01</td><td>0.27</td><td>0.25</td><td>0.02</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.01</td><td>0.08</td><td>0.03</td><td>0.05</td><td>0.07</td><td>0.00</td><td>0.00</td><td>0.05</td><td>0.00</td><td>0.11</td><td>0.04</td></tr>
	<tr><td>0.00</td><td>0.01</td><td>0.01</td><td>0.01</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.88</td><td>0.01</td><td>0.02</td><td>0.00</td><td>0.02</td><td>0.00</td><td>0.02</td><td>0.00</td><td>0.00</td><td>0.01</td><td>0.00</td><td>0.01</td><td>0.00</td></tr>
	<tr><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.99</td><td>0.00</td><td>0.00</td><td>0.01</td><td>0.00</td><td>0.00</td><td>0.00</td></tr>
	<tr><td>0.00</td><td>0.03</td><td>0.03</td><td>0.01</td><td>0.03</td><td>0.01</td><td>0.11</td><td>0.00</td><td>0.03</td><td>0.35</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.09</td><td>0.02</td><td>0.00</td><td>0.27</td><td>0.01</td><td>0.00</td><td>0.01</td></tr>
</tbody>
</table>





```R
vaild_label_extra2 <- predict(extraTreesModelFit, vaild_data[,-251], probability=F)
```


```R
extraCM <- confusionMatrix(vaild_label_extra2, vaild_data$cuisine)
```


```R
extraCM
```




    Confusion Matrix and Statistics
    
                  Reference
    Prediction     brazilian british cajun_creole chinese filipino french greek
      brazilian           80       2            0       0        4      0     0
      british              1      85            3       2        2     23     1
      cajun_creole         6       2          390       2        3     11     2
      chinese              1       5            2     910       51      6     2
      filipino             5       1            1      13      144      3     1
      french               3      50           21       6        5    554    17
      greek                0       3            0       1        0      9   309
      indian               5      11            7       8        7      8     6
      irish                1      14            0       1        3      5     0
      italian             24      45           56      13       18    299   102
      jamaican             3       1            0       0        0      4     0
      japanese             0       0            3      32        1      3     2
      korean               1       0            0      19        0      0     0
      mexican             27       5           39      12       17     15     8
      moroccan             2       1            0       2        1      6    10
      russian              1       5            0       0        2      3     3
      southern_us         13      90           92      21       24     99     5
      spanish              6       1            4       0        1      9     2
      thai                 7       0            0      20       14      0     0
      vietnamese           0       0            0       7        5      1     0
                  Reference
    Prediction     indian irish italian jamaican japanese korean mexican moroccan
      brazilian         0     0       3        1        1      0       5        0
      british           1    14      16        0        2      0       5        0
      cajun_creole      3     3      12        3        2      0       5        2
      chinese          10     1       5        7      107     53       6        1
      filipino          3     1       4        2        7      4       4        0
      french            7    33     118        2        6      0      23        8
      greek            13     2      37        0        0      0       1        8
      indian         1062     3      12       12       53      3      11       46
      irish             1    92       2        0        0      0       1        0
      italian          16    27    2743        2       25      5      65       28
      jamaican          5     1       1      125        0      0       0        1
      japanese          9     2       1        3      310     32       3        0
      korean            1     1       1        0       20    203       2        1
      mexican          32     7      61       21       10     10    2374       16
      moroccan          7     1       1        1        0      0       5      201
      russian           2     3       5        1        0      0       1        0
      southern_us      12    73      90       26       23     10      53        8
      spanish           2     2      18        1        0      0      10        6
      thai             13     0       1        2        3      6       1        1
      vietnamese        2     0       4        1        0      6       0        1
                  Reference
    Prediction     russian southern_us spanish thai vietnamese
      brazilian          1           4       0    0          0
      british            9          13       2    0          0
      cajun_creole       2          72      13    0          1
      chinese            2          18       0   54         52
      filipino           1          10       1    1          8
      french            26          67      35    1          1
      greek              4           4       7    2          0
      indian             9          27       4   38         10
      irish              5           8       4    0          1
      italian           28         161      94    5          4
      jamaican           1           4       0    2          0
      japanese           0           5       0    3          5
      korean             1           0       0    3          1
      mexican            6         111      47   16          9
      moroccan           0           6       6    0          2
      russian           63           7       1    0          0
      southern_us       36        1194      19    3          8
      spanish            1          13     159    0          1
      thai               0           1       2  463         72
      vietnamese         0           3       1   24        155
    
    Overall Statistics
                                              
                   Accuracy : 0.7304          
                     95% CI : (0.7235, 0.7373)
        No Information Rate : 0.1971          
        P-Value [Acc > NIR] : < 2.2e-16       
                                              
                      Kappa : 0.6967          
     Mcnemar's Test P-Value : NA              
    
    Statistics by Class:
    
                         Class: brazilian Class: british Class: cajun_creole
    Sensitivity                  0.430108       0.264798             0.63107
    Specificity                  0.998664       0.993967             0.99058
    Pos Pred Value               0.792079       0.474860             0.73034
    Neg Pred Value               0.993292       0.984991             0.98516
    Prevalence                   0.011696       0.020185             0.03886
    Detection Rate               0.005030       0.005345             0.02452
    Detection Prevalence         0.006351       0.011256             0.03358
    Balanced Accuracy            0.714386       0.629382             0.81082
                         Class: chinese Class: filipino Class: french Class: greek
    Sensitivity                 0.85126        0.476821       0.52363      0.65745
    Specificity                 0.97418        0.995513       0.97110      0.99410
    Pos Pred Value              0.70379        0.672897       0.56358      0.77250
    Neg Pred Value              0.98912        0.989929       0.96622      0.98961
    Prevalence                  0.06722        0.018990       0.06653      0.02955
    Detection Rate              0.05722        0.009055       0.03484      0.01943
    Detection Prevalence        0.08131        0.013457       0.06181      0.02515
    Balanced Accuracy           0.91272        0.736167       0.74737      0.82578
                         Class: indian Class: irish Class: italian Class: jamaican
    Sensitivity                0.88426     0.345865         0.8750        0.595238
    Specificity                0.98095     0.997058         0.9203        0.998534
    Pos Pred Value             0.79136     0.666667         0.7295        0.844595
    Neg Pred Value             0.99045     0.988963         0.9677        0.994605
    Prevalence                 0.07552     0.016726         0.1971        0.013205
    Detection Rate             0.06678     0.005785         0.1725        0.007860
    Detection Prevalence       0.08439     0.008678         0.2364        0.009306
    Balanced Accuracy          0.93261     0.671461         0.8977        0.796886
                         Class: japanese Class: korean Class: mexican
    Sensitivity                  0.54482       0.61145         0.9219
    Specificity                  0.99322       0.99672         0.9648
    Pos Pred Value               0.74879       0.79921         0.8350
    Neg Pred Value               0.98328       0.99176         0.9846
    Prevalence                   0.03578       0.02088         0.1619
    Detection Rate               0.01949       0.01276         0.1493
    Detection Prevalence         0.02603       0.01597         0.1788
    Balanced Accuracy            0.76902       0.80409         0.9434
                         Class: moroccan Class: russian Class: southern_us
    Sensitivity                  0.61280       0.323077            0.69097
    Specificity                  0.99673       0.997835            0.95026
    Pos Pred Value               0.79762       0.649485            0.62875
    Neg Pred Value               0.99189       0.991649            0.96187
    Prevalence                   0.02063       0.012262            0.10866
    Detection Rate               0.01264       0.003962            0.07508
    Detection Prevalence         0.01585       0.006099            0.11941
    Balanced Accuracy            0.80477       0.660456            0.82062
                         Class: spanish Class: thai Class: vietnamese
    Sensitivity                0.402532     0.75285          0.469697
    Specificity                0.995035     0.99065          0.996468
    Pos Pred Value             0.673729     0.76403          0.738095
    Neg Pred Value             0.984936     0.99006          0.988849
    Prevalence                 0.024838     0.03867          0.020751
    Detection Rate             0.009998     0.02911          0.009747
    Detection Prevalence       0.014840     0.03811          0.013205
    Balanced Accuracy          0.698783     0.87175          0.733083




```R
extraPredict_Prob <- apply(vaild_label_extra, 1, which.max)
```


```R
multiclass.roc(response=vaild_data$cuisine, predictor=extraPredict_Prob, levels=levels(vaild_data$cuisine),percent=TRUE)
```




    
    Call:
    multiclass.roc.default(response = vaild_data$cuisine, predictor = extraPredict_Prob,     levels = levels(vaild_data$cuisine), percent = TRUE)
    
    Data: extraPredict_Prob with 20 levels of vaild_data$cuisine: brazilian, british, cajun_creole, chinese, filipino, french, greek, indian, irish, italian, jamaican, japanese, korean, mexican, moroccan, russian, southern_us, spanish, thai, vietnamese.
    Multi-class area under the curve: 73.4%




```R
extraPredict_test <- predict(extraTreesModelFit, newdata = test_data[,-251], probability=F)
```


```R
head(extraPredict_test)
```




<ol class=list-inline>
	<li>irish</li>
	<li>southern_us</li>
	<li>italian</li>
	<li>cajun_creole</li>
	<li>italian</li>
	<li>southern_us</li>
</ol>





```R
extra_test_predict <- data.frame(id = test$id, cuisine = extraPredict_test)
```


```R
head(extra_test_predict)
```




<table>
<thead><tr><th></th><th scope=col>id</th><th scope=col>cuisine</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>18009</td><td>irish</td></tr>
	<tr><th scope=row>2</th><td>28583</td><td>southern_us</td></tr>
	<tr><th scope=row>3</th><td>41580</td><td>italian</td></tr>
	<tr><th scope=row>4</th><td>29752</td><td>cajun_creole</td></tr>
	<tr><th scope=row>5</th><td>35687</td><td>italian</td></tr>
	<tr><th scope=row>6</th><td>38527</td><td>southern_us</td></tr>
</tbody>
</table>





```R
head(test_predict)
```




<table>
<thead><tr><th></th><th scope=col>id</th><th scope=col>cuisine</th></tr></thead>
<tbody>
	<tr><th scope=row>39775</th><td>18009</td><td>southern_us</td></tr>
	<tr><th scope=row>39776</th><td>28583</td><td>southern_us</td></tr>
	<tr><th scope=row>39777</th><td>41580</td><td>italian</td></tr>
	<tr><th scope=row>39778</th><td>29752</td><td>southern_us</td></tr>
	<tr><th scope=row>39779</th><td>35687</td><td>italian</td></tr>
	<tr><th scope=row>39780</th><td>38527</td><td>southern_us</td></tr>
</tbody>
</table>





```R
submission <- left_join(sample_sub, extra_test_predict, by="id")
submission <- submission[,-2]
colnames(submission) <- c("id", "cuisine")
write.csv(submission, file = 'extra_submission.csv', row.names = F)
```

### 두번째 submission 결과
<img src="extra_submission.jpg" alt="alt text" title="Title"/>
