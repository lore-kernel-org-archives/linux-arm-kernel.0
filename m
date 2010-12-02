From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Dec 2010 10:51:19 +0100
Subject: mounting ext3 with readonly but there is some writing on it.
In-Reply-To: <0LCS00K68N6XI4@ms11.samsung.com>
References: <0LCS00K68N6XI4@ms11.samsung.com>
Message-ID: <20101202095119.GP32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chun-Gil Lee,

On Thu, Dec 02, 2010 at 09:18:31AM +0000, ??? wrote:
> <HTML><HEAD><TITLE>Samsung Enterprise Portal mySingle</TITLE>
> <META content="text/html; charset=euc-kr" http-equiv=Content-Type>
> <STYLE id=mysingle_style>P {
> 	MARGIN-TOP: 5px; FONT-FAMILY: ???, arial; MARGIN-BOTTOM: 5px; FONT-SIZE: 9pt
> }
> TD {
> 	MARGIN-TOP: 5px; FONT-FAMILY: ???, arial; MARGIN-BOTTOM: 5px; FONT-SIZE: 9pt
> }
> LI {
> 	MARGIN-TOP: 5px; FONT-FAMILY: ???, arial; MARGIN-BOTTOM: 5px; FONT-SIZE: 9pt
> }
> BODY {
> 	FONT-FAMILY: ???, arial; FONT-SIZE: 9pt
> }
> </STYLE>
> 
> <META name=GENERATOR content=ActiveSquare></HEAD>
> <BODY>
> <P>Hi,</P>
> <P>&nbsp;</P>
> <P>I&nbsp;mounted a partition(ext3) in SDMMC with&nbsp;readonly&nbsp;option(ro).</P>
> <P>However, I found some write requests in&nbsp;block&nbsp;driver of SDMMC card.&nbsp;</P>
> <P>Is it possible?</P>
> <P>Does the kjournald generate write transaction regardless of mounting</P>
> <P>attribute?.</P>
> <P>Does&nbsp;anyone have&nbsp;idea&nbsp;how to mount it and&nbsp;to be&nbsp;not&nbsp;generate any&nbsp;</P>
> <P>write transaction with ext3?</P>
> <P>&nbsp;</P>
> <P>&nbsp;</P><!--SP:highvolt.lee-->
> <P>Thank you&nbsp;&nbsp;&nbsp;</P>
> <P>&nbsp;&nbsp;&nbsp;&nbsp;Chun-Gil Lee</P>
> <P>&nbsp;&nbsp;&nbsp;&nbsp;Email: &nbsp;highvolt.lee at samsung.com </P><!--highvolt.lee:EP--><BR>
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
