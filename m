From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Mon, 8 Feb 2010 07:30:34 -0700
Subject: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)
In-Reply-To: <229789.92421.qm@web51008.mail.re2.yahoo.com>
References: <ef6149ed5e1d228262c3d98421a836400095c1b7.1265385421.git.amit.kucheria@canonical.com>
	<229789.92421.qm@web51008.mail.re2.yahoo.com>
Message-ID: <86A0E76937111F4C92FABEC0A20988510442655D@az33exm21>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

the 2 parameters are what we(FSL) use for the correct settings for the mx51 babbage board.

Dinh 

-----Original Message-----
From: Fabio Estevam [mailto:fabioestevam at yahoo.com] 
Sent: Sunday, February 07, 2010 1:11 PM
To: amit.kucheria at verdurent.com; Amit Kucheria
Cc: linux at arm.linux.org.uk; Nguyen Dinh-R00091; s.hauer at pengutronix.de; grant.likely at secretlab.ca; Herring Robert-RA7055; linux-arm-kernel at lists.infradead.org; daniel at caiaq.de; bryan.wu at canonical.com; eric.miao at canonical.com; valentin.longchamp at epfl.ch
Subject: Re: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)

Hi Amit,

...

--- On Fri, 2/5/10, Amit Kucheria <amit.kucheria@canonical.com> wrote:
> +static void __init mx51_babbage_timer_init(void) {
> +??? mx51_clocks_init(32768, 24000000, 22579200, 24576000); }

Would you care to comment about the values of the last two parameters of this function?

Regards,

Fabio Estevam


      
