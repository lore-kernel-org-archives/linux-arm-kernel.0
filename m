From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Sat, 6 Feb 2016 20:54:28 +0100
Subject: [PATCH 1/2] ARM: dts: mx53qsb: Enable VPU support
In-Reply-To: <1372683396.4971.35.camel@pizza.hi.pengutronix.de>
References: <1372459759-10488-1-git-send-email-festevam@gmail.com>
 <1372683396.4971.35.camel@pizza.hi.pengutronix.de>
Message-ID: <20160206195428.GA10316@x240.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, Jul 01, 2013 at 02:56:36PM +0200, Philipp Zabel wrote:
> Hi Fabio,
> 
> Am Freitag, den 28.06.2013, 19:49 -0300 schrieb Fabio Estevam:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Enable Video Processing Unit (VPU) support.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > Depends on Philipp Zabel's patch:
> > [PATCH] ARM: dts: add sram for imx53 and imx6q
> > 
> > Philipp,
> > 
> > I tried using the original mx53 vpu firmware that comes with the FSL BSP, but it
> > failed to load:
> > 
> > coda 63ff4000.vpu: firmware get command error                                   
> > coda 63ff4000.vpu: HW initialization failed  
> > 
> > Any suggestions?
> > 
> > Thanks!
> 
> /*
>  * The CODA driver needs the raw firmware without header in memory order.
>  * This is how I converted vpu_fw_imx53.bin from the Freescale BSP into
>  * v4l2-coda7541-imx53.bin:
>  */

Sorry to revive an old thread but I was wondering if that firmware
conversion tool is available somewhere on a git repo?

Regards,
Gary
