From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Oct 2013 14:25:05 -0700
Subject: [PATCH 1/3] ARM: dts: omap4-panda: add DPI pinmuxing
In-Reply-To: <526F8ADA.3030003@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <526F8ADA.3030003@ti.com>
Message-ID: <20131029212505.GJ15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131029 03:16]:
> Hi Tony,
> 
> On 25/10/13 13:07, Tomi Valkeinen wrote:
> > New u-boot versions no longer set the pinmuxing for Panda's DPI output,
> > and the muxing has to be done in the .dts file.
> > 
> > Add pinmuxing for DPI and TFP410. Without these, the DVI output on Panda
> > does not work with recent u-boot.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> The two latter patches in this series needs more work and can be
> dropped, but this one should be applied to make Panda work properly with
> new u-boots.

OK I'll pick this patch into omap-for-v3.13/dt.

Regards,

Tony
