From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Thu, 24 Oct 2013 10:20:11 +0200
Subject: [PATCHv6][ 3/7] ARM: imx{25,27} DT: Permit the selection of the
 imxfb framebuffer driver.
In-Reply-To: <20131024081531.GA13614@S2101-09.ap.freescale.net>
References: <1382601665-6830-1-git-send-email-denis@eukrea.com>
 <1382601665-6830-3-git-send-email-denis@eukrea.com>
 <20131024081531.GA13614@S2101-09.ap.freescale.net>
Message-ID: <20131024102011.610e5d8b@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Le Thu, 24 Oct 2013 16:15:34 +0800,
Shawn Guo <shawn.guo@linaro.org> a ?crit :
> >  config FB_IMX
> >  	tristate "Freescale i.MX1/21/25/27 LCD support"
> > -	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
> > +	depends on FB && HAVE_IMX_FB
> 
> Or simply have it depend on ARCH_MXC?
> 
> 	depends on FB && ARCH_MXC
> 
but not all MXC have IMX_FB : isn't that a problem ?

Eric
