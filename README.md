# ECODORM
This project was a part of the Ideathon at Sendai Kosen Global Camp, held from 2–6 May 2026. The theme was to design a system to promote sustainability and promote environmental protection. We decided to work on a campagne that encourages students in dormitory to save energy.

As the entire prototyping process—including brainstorming and development—was limited to only 12 hours, we focused primarily on UI design and backend system architecture. We were unable to fully integrate the mock application with the server due to time constaints, so dummy data is used in the application for demonstration.

### Campagne Idea
Our proposal is to use rewards to encourage students to save energy and produce less waste. Students can see their points and their rank on the mobile application that we develop. The students in the highest ranks will be rewarded wih food coupons or discount coupons while the students in the lowest ranks will be assigned for volunteer activities as ~penalties~. The scores are reset every week or every month.

A student's can gain points by
* participating in volunteer activities
* disposing cans and bottles in the recycle bin and scan QR code to register
* saving electricity and get extra points if their room uses the least power each week

The points will be reduced if
* They use air conditioner longer than 8 hours within 24 hours
* They forget to turn off the lights in their bedroom during class time
Admins can impose other rules.

## Application Description
### Login
Our login system is very simple. We do not need to store password in our database since we aim to integrate our system into campus database. We propose 2 approaches for authentication.
* The server sends a verification email to user's student email in order to authenticate
* The application requires authentication from the campus application (such as MyID at Sendai Kosen)
We did not implement any of these approaches in our code due to security problems. The authentication part is entirely skipped in this repo.

### Coupons
System admin publishes the reward coupons each week or month. The coupons rewarded to each student will be shown in the app once they log in. As the coupons is used at school canteen or at a vending machine, it gets deleted. 

### QR
The QR code can be used for identification in various scenarios. For example, user can get their code scanned at the recycle bin when they dispose the garbage, then the bin sends data to the server to gain points.

### Server
The server is RESTful API-based. At the current steps, we have implemented the following services. \ 
`/students` for retrieving user data \
`/scores` for setting and retrieving user scores \
`/recycle` for updating and retrieving recycle bin usage history as well as updating scores \
`/coupons` for retrieving coupons and update status

## Contributors
* [M](https://github.com/WanakitsamphanTh) (Mock app coding and API design)
* [Credit](https://github.com/credit7033) (Backend coding and testing)
* [Kenza](https://github.com/KenzaB3108) (Product design and presentation)
* [Raizou](https://github.com/s2402315-hash) (Product design and coding)

