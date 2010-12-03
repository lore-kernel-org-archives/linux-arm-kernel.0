From: highvolt.lee@samsung.com (CHUNGIL LEE)
Date: Fri, 03 Dec 2010 00:30:35 +0000 (GMT)
Subject: mounting ext3 with readonly but there is some writing on it.
Message-ID: <18246703.117531291336235333.JavaMail.weblogic@epml06>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thank you for the web-site that is helpful to me.
And Sorry for the email made by html.
Next time, I will ask it to the mailing list. :)

Chun-Gil Lee.

 
 

------- Original Message -------
Sender : Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
Date : 2010-12-02 18:51 (GMT+09:00)
Title : Re: mounting ext3 with readonly but there is some writing on it.

Hello Chun-Gil Lee, 

On Thu, Dec 02, 2010 at 09:18:31AM +0000, ??? wrote: 
> <HTML><HEAD><TITLE>Samsung Enterprise Portal mySingle</TITLE> 
> <META content="text/html; charset=euc-kr" http-equiv=Content-Type> 
> <STYLE id=mysingle_style>P { 
>     MARGIN-TOP: 5px; FONT-FAMILY: ???, arial; MARGIN-BOTTOM: 5px; FONT-SIZE: 9pt 
> } 
> TD { 
>     MARGIN-TOP: 5px; FONT-FAMILY: ???, arial; MARGIN-BOTTOM: 5px; FONT-SIZE: 9pt 
> } 
> LI { 
>     MARGIN-TOP: 5px; FONT-FAMILY: ???, arial; MARGIN-BOTTOM: 5px; FONT-SIZE: 9pt 
> } 
> BODY { 
>     FONT-FAMILY: ???, arial; FONT-SIZE: 9pt 
> } 
> </STYLE> 
>  
> <META name=GENERATOR content=ActiveSquare></HEAD> 
> <BODY> 
> <P>Hi,</P> 
> <P> </P> 
> <P>I mounted a partition(ext3) in SDMMC with readonly option(ro).</P> 
> <P>However, I found some write requests in block driver of SDMMC card. </P> 
> <P>Is it possible?</P> 
> <P>Does the kjournald generate write transaction regardless of mounting</P> 
> <P>attribute?.</P> 
> <P>Does anyone have idea how to mount it and to be not generate any </P> 
> <P>write transaction with ext3?</P> 
> <P> </P> 
> <P> </P><!--SP:highvolt.lee--> 
> <P>Thank you   </P> 
> <P>    Chun-Gil Lee</P> 
> <P>    Email:  highvolt.lee at samsung.com </P><!--highvolt.lee:EP--><BR> 
> <TABLE id=confidentialsignimg> 
> <TBODY> 
> <TR> 
> <TD NAMO_LOCK> 
> <P><IMG border=0 src="cid:QKNMBDIFBEI0@namo.co.kr" width=520></P></TD></TR></TBODY></TABLE> 
> <P></P></BODY></HTML> 
Can you please advise your mail program to send plain text mails to this 
mailing list (and probably to all other Linux related lists, too), I'm 
sure I'm not the only person using a text-mode MUA. 

And note that your problem isn't specific to ARM, so this is the wrong 
mailing list.  I suggest linux-ext4 at vger.kernel.org which despite the 
name also cares for ext3.  Or still better ask google which finds e.g. 
http://pavelmachek.livejournal.com/64695.html for when when looking for 
"ext3 read only". 

Best regards 
Uwe 

--  
Pengutronix e.K.                           | Uwe Kleine-K?nig            | 
Industrial Linux Solutions                 | http://www.pengutronix.de/  | 

 
 
    ??? ??
 
    Chun-Gil Lee
    Engineer
    Application Processor Development 
    System LSI Division
    SAMSUNG ELECTRONICS, Co., Ltd. 

    Phone:  +82-31-209-4593
    Mobile: +82-10-8985-4885
    Fax:    +82-31-209-0837
    Email:  highvolt.lee at samsung.com 
 
 
