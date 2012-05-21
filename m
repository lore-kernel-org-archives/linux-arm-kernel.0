From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Mon, 21 May 2012 15:33:22 +0200
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <CAOMZO5DNSRCknE2Z-rmUjBsJWaiZdRb=8hrNw2N=u4OsqyX1AQ@mail.gmail.com>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
 <20120518085922.GQ30400@pengutronix.de>
 <CAOMZO5DNSRCknE2Z-rmUjBsJWaiZdRb=8hrNw2N=u4OsqyX1AQ@mail.gmail.com>
Message-ID: <3280708.6NjLuBzCWZ@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi 21 mai 2012 10:20:09 Fabio Estevam a ?crit :
> Hi Sascha,
> 
> On Fri, May 18, 2012 at 5:59 AM, Sascha Hauer <s.hauer@pengutronix.de> 
wrote:
> 
> ,if I remove the spi driver then the boots complete.
> 
> I am debugging this now, but any suggestions are welcome.

Try to disable the MC13783 Pmic. On mx31moboard I have the same hang and I can 
clearly see that the board switchoff itself. 
It looks like somebody is writing in the wrong register (regmap code?).

Regards,

Philippe
