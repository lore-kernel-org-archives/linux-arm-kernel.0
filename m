From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 25 Feb 2010 14:09:16 -0800 (PST)
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <1267095523.2722.40.camel@realization>
Message-ID: <505892.36787.qm@web51002.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

--- On Thu, 2/25/10, Alberto Panizzo <maramaopercheseimorto@gmail.com> wrote:

> From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> Subject: Re: [PATCH] mx31pdk: Add NAND support
> To: "Fabio Estevam" <fabioestevam@yahoo.com>
> Cc: s.hauer at pengutronix.de, linux-arm-kernel at lists.infradead.org
> Date: Thursday, February 25, 2010, 8:58 AM
> On mer, 2010-02-24 at 16:58 -0800,
> Fabio Estevam wrote:
> > Add NAND support to MX31PDK board.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> 
> Mmm.. maybe I waited too much before pull my work on this
> board..
> Fabio, don't you think to change the namespace in
> mach-mx31_3ds
> to accomplish to the new machine file name before adding
> some more 
> functionality?

I am not a big fan of the mach-mx31_3ds name. I know that this comes from the MACH name, but the name we use these days is MX31PDK as it is advertised on Freescale's website (www.freescale.com/imx31pdk).

Should we really rename all mx31pdk references inside mach-mx31_3ds.c ?

U-boot also references this board as mx31pdk.

MX35PDK board seems not to follow the same logic:
MACH name is MX35_3DS and board name is mach-mx35pdk.c

I prefer the MX35 approach.

Regards,

Fabio Estevam


 


      
