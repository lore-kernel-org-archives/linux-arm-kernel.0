From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 21 May 2012 10:35:42 -0300
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <3280708.6NjLuBzCWZ@laptop>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
 <20120518085922.GQ30400@pengutronix.de>
 <CAOMZO5DNSRCknE2Z-rmUjBsJWaiZdRb=8hrNw2N=u4OsqyX1AQ@mail.gmail.com>
 <3280708.6NjLuBzCWZ@laptop>
Message-ID: <CAOMZO5DHNXkc9wAMapQgtfPujSEcMvFvuSSZfJPb2nM5fm3sUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 10:33 AM, Philippe R?tornaz
<philippe.retornaz@epfl.ch> wrote:

> Try to disable the MC13783 Pmic. On mx31moboard I have the same hang and I can
> clearly see that the board switchoff itself.
> It looks like somebody is writing in the wrong register (regmap code?).

You are right. If I disable the mc13783 driver then the boots proceed.

I will take a look at the mc13783 driver. If you also spot anything
wrong there, please let us know.

Thanks,

Fabio Estevam
