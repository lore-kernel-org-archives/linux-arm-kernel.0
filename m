From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Tue, 9 Feb 2010 09:56:13 -0700
Subject: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)
In-Reply-To: <784058.93145.qm@web51001.mail.re2.yahoo.com>
References: <229789.92421.qm@web51008.mail.re2.yahoo.com>
	<784058.93145.qm@web51001.mail.re2.yahoo.com>
Message-ID: <86A0E76937111F4C92FABEC0A209885104426873@az33exm21>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

-----Original Message-----
From: Fabio Estevam [mailto:fabioestevam at yahoo.com] 
Sent: Monday, February 08, 2010 6:46 PM
To: amit.kucheria at verdurent.com; Amit Kucheria
Cc: linux at arm.linux.org.uk; Nguyen Dinh-R00091; s.hauer at pengutronix.de; grant.likely at secretlab.ca; Herring Robert-RA7055; valentin.longchamp at epfl.ch; daniel at caiaq.de; bryan.wu at canonical.com; eric.miao at canonical.com; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)



--- On Sun, 2/7/10, Fabio Estevam <fabioestevam@yahoo.com> wrote:

> From: Fabio Estevam <fabioestevam@yahoo.com>
> Subject: Re: [PATCHv3 5/7] mxc: Add support for the Babbage board 
> (i.MX5)
> To: amit.kucheria at verdurent.com, "Amit Kucheria" 
> <amit.kucheria@canonical.com>
> Cc: linux at arm.linux.org.uk, Dinh.Nguyen at freescale.com, 
> s.hauer at pengutronix.de, grant.likely at secretlab.ca, 
> r.herring at freescale.com, valentin.longchamp at epfl.ch, daniel at caiaq.de, 
> bryan.wu at canonical.com, eric.miao at canonical.com, 
> linux-arm-kernel at lists.infradead.org
> Date: Sunday, February 7, 2010, 5:10 PM Hi Amit,
> 
> ...
> 
> --- On Fri, 2/5/10, Amit Kucheria <amit.kucheria@canonical.com>
> wrote:
> > +static void __init mx51_babbage_timer_init(void) {
> > +??? mx51_clocks_init(32768, 24000000, 22579200,
> 24576000);
> > +}
> 
> Would you care to comment about the values of the last two parameters 
> of this function?

I can see all oscillator values on MX51EVK schematics, except the last one (24.576 MHz). Where did you get this value from?

[DN] It may not be shown from the schematic, but this is value we(FSL) received from the board design team.

Regards,

Fabio Estevam




      
