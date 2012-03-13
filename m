From: alexg@meprolight.com (Alex Gershgorin)
Date: Tue, 13 Mar 2012 15:50:35 +0200
Subject: [PATCH] i.MX35-PDK: Add Camera support
In-Reply-To: <20120313133333.GG3852@pengutronix.de>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CBD666A2A@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Thanks for you comments.
 
> In i.MX35-PDK, OV2640  camera is populated on the
> personality board. This camera is registered as a subdevice via soc-camera interface.
> 
> Signed-off-by: Alex Gershgorin <alexg@meprolight.com>
> ---
>  arch/arm/mach-imx/mach-mx35_3ds.c |   87 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 87 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c

> > This one does not apply as it is obviously based on (an earlier version
> > of) the framebuffer patches of this board. Please always base your stuff
> > on some -rc kernel. We can resolve conflicts later upstream, but we
> > cannot easily apply a patch when we do not have the correct base.

> >Please add the linux arm kernel mailing list next time.

Oh what a stupid mistake, I will correct it.

Regards,

Alex Gershgorin
