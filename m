From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Mon, 8 Feb 2010 16:46:29 -0800 (PST)
Subject: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)
In-Reply-To: <229789.92421.qm@web51008.mail.re2.yahoo.com>
Message-ID: <784058.93145.qm@web51001.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Sun, 2/7/10, Fabio Estevam <fabioestevam@yahoo.com> wrote:

> From: Fabio Estevam <fabioestevam@yahoo.com>
> Subject: Re: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)
> To: amit.kucheria at verdurent.com, "Amit Kucheria" <amit.kucheria@canonical.com>
> Cc: linux at arm.linux.org.uk, Dinh.Nguyen at freescale.com, s.hauer at pengutronix.de, grant.likely at secretlab.ca, r.herring at freescale.com, valentin.longchamp at epfl.ch, daniel at caiaq.de, bryan.wu at canonical.com, eric.miao at canonical.com, linux-arm-kernel at lists.infradead.org
> Date: Sunday, February 7, 2010, 5:10 PM
> Hi Amit,
> 
> ...
> 
> --- On Fri, 2/5/10, Amit Kucheria <amit.kucheria@canonical.com>
> wrote:
> > +static void __init mx51_babbage_timer_init(void)
> > +{
> > +??? mx51_clocks_init(32768, 24000000, 22579200,
> 24576000);
> > +}
> 
> Would you care to comment about the values of the last two
> parameters of this function?

I can see all oscillator values on MX51EVK schematics, except the last one (24.576 MHz). Where did you get this value from?

Regards,

Fabio Estevam




      
