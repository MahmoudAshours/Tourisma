# **Tourisma**

![](RackMultipart20210127-4-1mrqpyl_html_34b9f556e7c80397.png)

**What is Tourisma?**

Tourisma is a machine learning recommendation mobile application which recommends places for you to go based on your personal interests &amp; favorite places.

**Tools used :**

**Flutter**

**Flutter** SDK is Google&#39;s UI toolkit for crafting beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.

**Dart**

**Dart** is a client-optimized programming language for apps on multiple platforms. It is developed by Google and is used to build mobile, desktop, server, and web applications.

**Python**

Python is an interpreted, high-level and general-purpose programming language. Python&#39;s design philosophy emphasizes code readability with its notable use of significant whitespace.

**Flask**

Flask is a micro web framework written in Python. It is classified as a microframework because it does not require particular tools or libraries. It has no database abstraction layer, form validation, or any other components where pre-existing third-party libraries provide common functions.

**The project consists of 2 main components :**

First component :

**Front end:**

Front end or the mobile application which is developed using Flutter, can be deployed into Android &amp; IOS

**Back end :**

There are 2 back-end servers used in Tourisma

First: Backend server which hosts Flask application which processes the recommendation and sends it back to the mobile application.

Second: Firebase server which carries the database of each user signed up on Tourism.

**Front end :**

The central idea is that you build your UI out of **widgets**. **Widgets** describe what their view should look like given their current configuration and state.

In flutter , everything is a widget.

Project structure :

![](RackMultipart20210127-4-1mrqpyl_html_190b74e4b0848590.png)

#### **Android and iOS directories**

- _Android_ and _iOS_ directories hold a complete Android and iOS app respectively, with all their respective files. Whenever you want to implement any platform specific feature you can implement it by going in these directories.

#### **lib directory**

- The _lib_ directory holds all your code used to run your app.

#### **pubspec.yaml**

- pubspec.yaml is a special file. It contains your _app name_, _description_, _SDK version_, _dependencies_, and other important stuff.
- **Assets Directory**
  - This is where all images / fonts used in the application are located.

**Project widgets / components :**

I&#39;ll explain the widgets briefly :

**Signing in:**

The project starts with a &quot;Sign-in&quot; screen , which has 2 text fields :

- E-mail
- Password

Email component :

```

classEmailComponentextendsStatelessWidget {

@override

Widgetbuild(BuildContext context) {

returnConsumer\&lt;SignInBloc\&gt;(

builder: (\_, \_bloc, \_\_) =\&gt; Container(

child: AnimatedTextFeild(

textField: TextField(

onChanged: (email) =\&gt; \_bloc.email = email,

decoration: InputDecoration(

contentPadding: constEdgeInsets.only(left: 8.0),

border: InputBorder.none,

hintText: &#39;Email&#39;,

hintStyle: TextStyle(color: Colors.purple[100])),

style: TextStyle(color: Colors.purple[100]),

),

borderColor: Colors.purple[100],

icon: Center(

child: FaIcon(

FontAwesomeIcons.envelope,

color: Colors.purple[100],

),

),

),

),

);

}

}

```

The email component stores the Email the user entered &amp; waits for the user to insert the password.

The above code is _the email\_component.dart_ file.

The code is pretty easy , some properties for the button color - border color etc..

**Password widget :**

```

class\_PasswordComponentStateextendsState\&lt;PasswordComponent\&gt; {

bool \_obsecurity = true;

@override

Widgetbuild(BuildContext context) {

returnConsumer\&lt;SignInBloc\&gt;(

builder: (\_, \_bloc, \_\_) =\&gt; Container(

child: AnimatedTextFeild(

textField: TextField(

obscureText: \_obsecurity,

onChanged: (password) =\&gt; \_bloc.password = password,

decoration: InputDecoration(

contentPadding: constEdgeInsets.only(left: 8.0),

border: InputBorder.none,

hintText: &#39;Password&#39;,

icon: IconButton(

icon: Icon(Icons.remove\_red\_eye),

onPressed: () =\&gt; setState(() =\&gt;

\_obsecurity ? \_obsecurity = false : \_obsecurity = true)),

hintStyle: TextStyle(color: Colors.amber[100]),

),

style: TextStyle(color: Colors.amber[100]),

),

borderColor: Colors.amber[100],

icon: Center(

child: FaIcon(

FontAwesomeIcons.lock,

color: Colors.amber[100],

),

),

),

),

);

}

}

```

The same goes for the password component , The password component stores the password the user entered &amp; waits for the user to click the sign in button to send it to Firebase , to either accept it or decline it.

The above code is _the password\_component.dart_ file.

The code is pretty easy , some properties for the button color - border color etc..

**Sign in widget :**

```

classSignInButtonextendsStatelessWidget {

@override

Widgetbuild(BuildContext context) {

returnConsumer\&lt;SignInBloc\&gt;(

builder: (\_, \_bloc, \_\_) =\&gt; Container(

width: 140,

height: 100,

decoration: BoxDecoration(shape: BoxShape.circle),

child: FlatButton(

splashColor: Colors.transparent,

highlightColor: Colors.transparent,

onPressed: () =\&gt; \_bloc.signIn(context),

child: Row(

children: [

Expanded(

flex: 1,

child: GradientText(

&quot;Sign in!&quot;,

gradient: LinearGradient(

colors: [

Colors.deepPurple,

Colors.purple[100],

Colors.amber[100]

],

),

style: TextStyle(fontSize: 18),

textAlign: TextAlign.start,

),

),

SizedBox(width: 10),

FaIcon(FontAwesomeIcons.arrowCircleRight)

],

),

),

),

);

}

}

```

Sign in function :

voidsignIn(BuildContext context) {

\_authService.signIn(&#39;$email&#39;, &#39;$password&#39;, context).then(

(String uid) {

if (uid != null) {

\_userUID = uid;

notifyListeners();

routePush(PlacesRecommendation(), RouterType.fade);

notifyListeners();

}

},

);

}

The sign in widget calls the sign in function if clicked on :

- The combination between email and password are sent to Firebase
- If the combination between Email and password are correct , the firebase returns with a response that the user is authenticated which then sends the user to the other screen.
- If the combination between Email and password are wrong , the firebase returns with a response that the user is not authenticated which then sends the user an error message that they should check their Email/password.

**SignUp :**

If the user doesn&#39;t have an account on the application. The user should sign up.

The sign up screen consists of 3 parts :

- Email
- Password
- Confirm password (for security)

**Email Widget :**

```

classEmailSignUpextendsStatelessWidget {

@override

Widgetbuild(BuildContext context) {

returnConsumer\&lt;SignUpBloc\&gt;(

builder: (\_, \_bloc, \_\_) =\&gt; Container(

child: AnimatedTextFeild(

textField: TextField(

onChanged: (email) =\&gt; \_bloc.email = email,

decoration: InputDecoration(

contentPadding: constEdgeInsets.only(left: 8.0),

border: InputBorder.none,

hintText: &#39;Email&#39;,

errorText: \_bloc.validateEmail ? null : &quot;Your e-mail isn&#39;t valid&quot;,

hintStyle: TextStyle(color: Colors.purple[100]),

),

style: TextStyle(color: Colors.purple[100]),

),

borderColor: Colors.purple[100],

icon: Center(

child: FaIcon(

FontAwesomeIcons.envelope,

color: Colors.purple[100],

),

),

),

),

);

}

}

```

The above code is _email\_signup.dart_ .

This widget is a text field where the email should be written into &amp; then checks whether the email is written in the right format or not.

&quot; Any Email should contain &#39;@&#39; and &#39;.&#39; &quot;

**Password Widget**

```

class\_PasswordComponentStateextendsState\&lt;PasswordSignUp\&gt; {

bool \_obsecurity = true;

@override

Widgetbuild(BuildContext context) {

returnConsumer\&lt;SignUpBloc\&gt;(

builder: (\_, \_bloc, \_\_) =\&gt; Container(

child: AnimatedTextFeild(

textField: TextField(

obscureText: \_obsecurity,

onChanged: (password) =\&gt; \_bloc.password = password,

decoration: InputDecoration(

contentPadding: constEdgeInsets.only(left: 8.0),

border: InputBorder.none,

hintText: &#39;Password&#39;,

errorMaxLines: 4,

errorText: \_bloc.validatePassword

? null

: &quot;Your Password should be at least 8 characters , contains uppercase and symbol&quot;,

icon: IconButton(

icon: Icon(Icons.remove\_red\_eye),

onPressed: () =\&gt; setState(() =\&gt;

\_obsecurity ? \_obsecurity = false : \_obsecurity = true)),

hintStyle: TextStyle(color: Colors.amber[100]),

),

style: TextStyle(color: Colors.amber[100]),

),

borderColor: Colors.amber[100],

icon: Center(

child: FaIcon(

FontAwesomeIcons.lock,

color: Colors.amber[100],

),

),

),

),

);

}

}

```

The above code is _password\_signup.dart_ .

This widget is a text field where the password should be written into &amp; then checks whether the password is at least 8 characters for security purposes.

**Sign up button :**

classSignUpButtonextendsStatelessWidget {

@override

Widgetbuild(BuildContext context) {

returnConsumer\&lt;SignUpBloc\&gt;(

builder: (\_, \_bloc, \_\_) =\&gt; Container(

width: 140,

height: 100,

decoration: BoxDecoration(shape: BoxShape.circle),

child: FlatButton(

splashColor: Colors.transparent,

highlightColor: Colors.transparent,

onPressed: () =\&gt; \_bloc.signUp(context),

child: Row(

children: [

Expanded(

flex: 1,

child: Text(

&quot;Sign Up!&quot;,

style: TextStyle(fontSize: 18),

textAlign: TextAlign.start,

),

),

SizedBox(width: 10),

FaIcon(FontAwesomeIcons.arrowCircleRight)

],

),

),

),

);

}

}

The above code is _signupbutton\_component.dart_

voidsignUp(BuildContext context) {

if (!\_validator.validateEmailMessage(email)) {

validateEmail = false;

notifyListeners();

} elseif (!\_validator.validatePasswordMessage(password)) {

validatePassword = false;

notifyListeners();

} elseif (password != confirmPassword) {

validateConfirmPassword = false;

notifyListeners();

} else {

validateEmail = true;

validatePassword = true;

validateConfirmPassword = true;

notifyListeners();

\_authService.signUp(&#39;$email&#39;, &#39;$password&#39;, context).then(

(String uid) {

if (uid != null) {

\_userUID = uid;

populate(context, uid);

notifyListeners();

routePush(PlacesRecommendation(), RouterType.fade);

}

},

);

}

}

The above code is _ **signUp function** _

This widget calls the sign up method which checks if the user entered a valid email ( also makes sure that the user didn&#39;t enter any empty text) and then sends a request to Firebase to create a new user.

Then redirects the user to the Home page of the application.

**The body of the application :**

When the user is redirected from Authentication , they&#39;re redirected to

_Places\_recommendation.dart_

_```_

_class __PlacesRecommendation__ extends__StatefulWidget_ _{_

_final__String_ _uid;_

_final__SignInBloc_ _bloc;_

_PlacesRecommendation__({__this __.uid,_ _this__.bloc});_

_@override_

_\_PlacesRecommendationState __createState__ () =\&gt;_ _\_PlacesRecommendationState__();_

_}_

_class __\_PlacesRecommendationState__ extends __State__ \&lt; __PlacesRecommendation__ \&gt; {_

_@override_

_void __initState__ () {_

_if_ _(widget.uid !=_ _null__) widget.bloc..userUID = widget.uid;_

_super __.__ initState__();_

_}_

_int_ _\_currentIndex =_ _0__;_

_@override_

_Widget __build__ (__BuildContext_ _context) {_

_return __Scaffold__ (_

_backgroundColor:_ _Color__(__0xff47516C__),_

_body:_ _SafeArea__(_

_child:_ _Center__(_

_child:_ _Column__(_

_mainAxisAlignment:_ _MainAxisAlignment__.spaceAround,_

_children: [_

_\_currentIndex ==_ _0_

_?_ _PlacesList__(widget.uid)_

_:_ _TripList__(uid: widget.uid),_

_Padding__(_

_padding:_ _const __EdgeInsets__. __all__ ( __8.0__ ),_

_child:_ _Row__(_

_mainAxisAlignment:_ _MainAxisAlignment__.spaceAround,_

_children: [_

_GestureDetector__(_

_onTap: () =\&gt;_ _setState__(() =\&gt; \_currentIndex =_ _0__),_

_child:_ _Container__(_

_width:_ _150__,_

_height:_ _50__,_

_decoration:_ _BoxDecoration__(_

_borderRadius:_ _BorderRadius __.__ circular__(__30__),_

_gradient:_ _LinearGradient__(_

_begin:_ _Alignment__.topLeft,_

_colors: [_

_Color__(__0xff7558FF__),_

_Color__(__0xff3396FF__),_

_Color__(__0xff1AB0FF__)_

_]),_

_),_

_child:_ _Row__(_

_mainAxisAlignment:_ _MainAxisAlignment__.center,_

_children: [_

_Padding__(_

_padding:_ _const __EdgeInsets__. __all__ ( __8.0__ ),_

_child:_ _Icon__(_

_Icons__.place,_

_color:_ _Colors__.white,_

_),_

_),_

_Text__(_

_&#39;Ratings&#39;__,_

_style:_

_TextStyle__(fontSize:_ _21__, color:_ _Colors__.white),_

_),_

_],_

_),_

_),_

_),_

_GestureDetector__(_

_onTap: () =\&gt;_ _setState__(() =\&gt; \_currentIndex =_ _1__),_

_child:_ _Container__(_

_width:_ _150__,_

_height:_ _50__,_

_decoration:_ _BoxDecoration__(_

_gradient:_ _LinearGradient__(_

_begin:_ _Alignment__.topLeft,_

_colors: [_

_Color__(__0xffFFC300__),_

_Color__(__0xffFFB400__),_

_Color__(__0xffFF9E00__)_

_]),_

_borderRadius:_ _BorderRadius __.__ circular__(__30__),_

_),_

_child:_ _Row__(_

_mainAxisAlignment:_ _MainAxisAlignment__.center,_

_children: [_

_Padding__(_

_padding:_ _const __EdgeInsets__. __all__ ( __8.0__ ),_

_child:_ _Icon__(_

_Icons__.trip\_origin\_rounded,_

_color:_ _Colors__.black,_

_),_

_),_

_Text__(_

_&#39;Trip&#39;__,_

_style:_ _TextStyle__(_

_fontSize:_ _21__,_

_color:_ _Colors__.black,_

_fontWeight:_ _FontWeight__.w700),_

_),_

_],_

_),_

_),_

_),_

_],_

_),_

_),_

_],_

_),_

_),_

_),_

_);_

_}_

_}_

_```_

The above code is the places recommendation screen which consists of 2 main parts :

- **Trip list widget**
- **Places list widget**

**Options :**

- When the user clicks on the trips button , the user gets redirected to the Trip list screen.
- When the user clicks on the Rating button , the user gets redirected to places list widgets.

**First : Places List**

This is the screen where the users can rate the places in the current city (i.e. Ismailia)

```

classPlacesListextendsStatelessWidget {

final uid;

PlacesList(this.uid);

@override

Widgetbuild(BuildContext context) {

final \_bloc = Provider.of\&lt;PlacesBloc\&gt;(context);

returnExpanded(

flex: 1,

child: Padding(

padding: constEdgeInsets.only(top: 60.0),

child: FadeInUp(

child: Padding(

padding: constEdgeInsets.all(8.0),

child: StreamBuilder(

stream: \_bloc.getUserPlaces(userID: uid),

builder: (\_, AsyncSnapshot\&lt;QuerySnapshot\&gt; snapshot) =\&gt; !snapshot

.hasData

? SizedBox()

: Container(

width: MediaQuery.of(context).size.width,

height: MediaQuery.of(context).size.width,

child: Center(

child: Swiper(

curve: Curves.decelerate,

itemBuilder: (BuildContext context, int index) =\&gt;

Container(

child: Center(

child: Column(

children: [

Text(

&#39;Places in Ismailia to rate!&#39;,

style: TextStyle(

fontSize: 21, color: Colors.white),

),

RatingBar.builder(

initialRating:

snapshot.data.docs[index].get(&#39;Rate&#39;) \*

1.0,

minRating: 0,

direction: Axis.horizontal,

allowHalfRating: true,

itemCount: 5,

itemPadding:

EdgeInsets.symmetric(horizontal: 4.0),

itemBuilder: (context, \_) =\&gt; Icon(

Icons.star,

color: Colors.amber,

),

onRatingUpdate: (rating) {

\_bloc.addUsersRate(

context,

snapshot.data.docs[index].id,

rating,

uid);

},

),

ClipRRect(

borderRadius: BorderRadius.circular(30),

child: Image.network(

&#39;${snapshot.data.docs[index].get(&#39;Image&#39;)}&#39;,

height: 300,

),

),

FadeInUp(

child: Padding(

padding: constEdgeInsets.all(8.0),

child: Text(

&#39;${snapshot.data.docs[index].id}&#39;,

style: TextStyle(

color: Colors.white, fontSize: 21),

),

),

),

FlatButton(

child: Container(

width: 300,

child: Row(

mainAxisAlignment:

MainAxisAlignment.center,

crossAxisAlignment:

CrossAxisAlignment.center,

children: [

Text(

&#39;Check on Google Maps&#39;,

style: TextStyle(

color: Colors.white,

fontSize: 19),

),

Padding(

padding: constEdgeInsets.all(3.0),

child: Icon(Icons.map\_rounded),

)

],

),

),

onPressed: () =\&gt; \_launchURL(

&#39;${snapshot.data.docs[index].get(&#39;Longitude&#39;)}&#39;,

&#39;${snapshot.data.docs[index].get(&#39;Latitude&#39;)}&#39;),

)

],

),

),

),

itemCount: snapshot.data.docs.length,

duration: 6,

itemWidth: 400,

fade: 0.3,

),

),

),

),

),

),

),

);

}

```

The above code is _places\_list.dart_

This screen loads the places data in Ismailia (Name , Image , Location) &amp; displays it in a slider.

Each slider item has its own rating bar.

When the user rates any item (place) in the list , It is sent to Firebase to update the user&#39;s data with the new rating.

**The second part is Trip List screen :**

classTripListextendsStatefulWidget {

final uid;

TripList({Key key, this.uid}) : super(key: key);

@override

\_TripListStatecreateState() =\&gt; \_TripListState();

}

class\_TripListStateextendsState\&lt;TripList\&gt; {

var result;

Map sd = Map();

addToMap(\_bloc) async {

Stream\&lt;QuerySnapshot\&gt; s = \_bloc.getUserPlaces(userID: widget.uid);

for (int i = 0; i \&lt; 16; i++) {

s.forEach(

(element) {

return sd.putIfAbsent(

element.docs[i].id,

() {

return element.docs[i].data();

},

);

},

);

}

FormData formData = newFormData();

Dio().options.headers = {&quot;content-type&quot;: &#39;application/json&#39;};

formData.fields.add(MapEntry(&#39;data&#39;, json.encode(sd)));

try {

awaitDio()

.post(

&quot;http://10.0.2.2:5000/api&quot;,

data: formData,

options: Options(

method: &#39;POST&#39;,

contentType: &#39;application/json&#39;,

responseType: ResponseType.json),

)

.then((value) =\&gt; setState(() =\&gt; result = value.data));

} catch (e) {

print(&#39;object&#39;);

}

}

@override

Widgetbuild(BuildContext context) {

print(result);

final \_bloc = Provider.of\&lt;PlacesBloc\&gt;(context);

returnFadeInUp(

child: Column(

children: [

Text(&#39;PortSaid&#39;, style: TextStyle(color: Colors.white)),

GestureDetector(

onTap: () =\&gt; addToMap(\_bloc),

child: Container(

child: Center(

child: GestureDetector(

child: Container(

width: 150,

height: 50,

decoration: BoxDecoration(

borderRadius: BorderRadius.circular(30),

gradient: LinearGradient(

begin: Alignment.topLeft,

colors: [

Color(0xff7558FF),

Color(0xff3396FF),

Color(0xff1AB0FF)

],

),

),

child: Center(

child: Text(

&#39;Recommend me!&#39;,

style: TextStyle(fontSize: 21, color: Colors.white),

),

),

),

),

),

),

),

result == null

? SizedBox()

: Padding(

padding: constEdgeInsets.only(top:18.0),

child: Container(

width: MediaQuery.of(context).size.width,

height: 300,

child: Swiper(

itemCount: 3,

curve: Curves.decelerate,

itemBuilder: (BuildContext context, int index) =\&gt; Container(

child: Center(

child: Column(

children: [

ClipRRect(

borderRadius: BorderRadius.circular(30),

child: Image.network(

&#39;${result[&#39;$index&#39;][0][&#39;Image&#39;]}&#39;,

height: 200,

),

),

FadeInUp(

child: Padding(

padding: constEdgeInsets.all(8.0),

child: Text(

&#39;${result[&#39;$index&#39;][0][&#39;Name&#39;]}&#39;,

style: TextStyle(

color: Colors.white, fontSize: 21),

),

),

),

FlatButton(

child: Container(

width: 300,

child: Row(

mainAxisAlignment: MainAxisAlignment.center,

crossAxisAlignment: CrossAxisAlignment.center,

children: [

Text(

&#39;Check on Google Maps&#39;,

style: TextStyle(

color: Colors.white, fontSize: 19),

),

Padding(

padding: constEdgeInsets.all(3.0),

child: Icon(Icons.map\_rounded),

)

],

),

),

onPressed: () {

\_launchURL(&#39;${result[&#39;$index&#39;][0][&#39;Longitude&#39;]}&#39;, &#39;${result[&#39;$index&#39;][0][&#39;Latitude&#39;]}&#39;);

},

)

],

),

),

),

),

),

)

],

),

);

}

The above code is _trip\_list.dart_

In the trip List screen , the user clicks on the &quot;Recommend!&quot; button.

User preferences (Ratings of places in his city) are sent to the backend server (Flask) to process it and get recommendations.

Then , when there is a response from the server it displays the recommended places in a slider displaying its Name , Image &amp; Location on the map (which can be opened using Google maps)

**Second Part :**

Back end :

Some mandatory libraries are used such as :

Turicreate

**Turi Create** simplifies the development of custom machine learning models. You don&#39;t have to be a machine learning expert to add recommendations,

Pandas

**Pandas** is a fast, powerful, flexible and easy to use open source data analysis and manipulation tool, built on top of the **Python** programming language.

The main code :

```

def helper(v):

data\_frame = pd.read\_json(v)

transposed\_data = data\_frame.T

f = open(&#39;users\_data.csv&#39;, &#39;w&#39;)

f.write(transposed\_data.to\_csv(index=False, quotechar=&#39;&quot;&#39;, quoting=csv.QUOTE\_NONNUMERIC))

f.close()

@app.route(&quot;/api&quot;, methods=[&quot;POST&quot;, &quot;GET&quot;])

def get\_recommendations():

incoming\_user\_data = request.form[&#39;data&#39;]

helper(incoming\_user\_data)

train\_data\_df = pd.read\_csv(&#39;users\_data.csv&#39;, sep=&#39;,&#39;)

test\_data\_df = pd.read\_csv(&#39;places\_togo.csv&#39;, sep=&#39;,&#39;)

# Convert the pandas dataframes to graph lab SFrames

train\_data\_df[&#39;Latitude&#39;] = pd.to\_numeric(train\_data\_df[&quot;Latitude&quot;])

test\_data\_df[&#39;Latitude&#39;] = pd.to\_numeric(test\_data\_df[&quot;Latitude&quot;])

train\_data = tc.SFrame(train\_data\_df)

test\_data = tc.SFrame(test\_data\_df)

data = train\_data + test\_data

model = tc.ranking\_factorization\_recommender.create(data, &#39;ID&#39;, &#39;PlaceID&#39;)

results = model.recommend()

first\_place = list(data.filter\_by(values=results[0][&#39;PlaceID&#39;], column\_name=&#39;PlaceID&#39;))

second\_place = list(data.filter\_by(values=results[1][&#39;PlaceID&#39;], column\_name=&#39;PlaceID&#39;))

third\_place = list(data.filter\_by(values=results[2][&#39;PlaceID&#39;], column\_name=&#39;PlaceID&#39;))

return {&#39;0&#39;: first\_place, &#39;1&#39;: second\_place, &#39;2&#39;: third\_place}

```

The processes are :

- Getting data from mobile application
  - Data are received in JSON format
- Converting data to CSV file
  - (table &amp; rows to use it in Pandas)
- Cleaning CSV files
  - Removing unnecessary data , changing format &amp; data types of columns.
- Saving it into _users\_data.csv_ file
- Loading _places\_togo.csv_ file
  - This file contains all places to visit in the other city (i.e. port said)
- Getting the similarities between the 2 files
  - Based on 4 meta datas :
   - Is the place considered a restaurant?
   - Is the place considered a shopping area?
   - Does the place have a lake?
    - Rating of place
- Computing the similarities &amp; iterating over it.
- Sending the recommended data back to the mobile application.

**Lastly :**

To check the firebase database :

- Go to https://Firebase.com
- Sign in to google account
  - Email : stemapplicationcap@gmail.com
  - Password : stem123\*\*
- Go to console
- Click on the Places project
- You can see the firebase console and users data

**How to run code :**

In order to run the code You should :

- Download Pycharm
- Install missing packages
- Run in terminal : flask run --host=0.0.0.0
- Connect the mobile with the same wifi of laptop
- Check the ip address of the laptop (usually has this format : **192.168.1.?** Where ? is changeable number)
- Insert it in the IP text field in the trip list screen
- Then press the recommend button and it should work!
