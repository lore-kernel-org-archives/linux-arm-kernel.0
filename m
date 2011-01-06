From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 6 Jan 2011 10:59:42 -0700 (MST)
Subject: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build
	break because of clktrctrl_mask
In-Reply-To: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1101061058260.22048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Jan 2011, Santosh Shilimkar wrote:

> struct clockdomain member clktrctrl_mask is available for only for OMAP2
> and OMAP3 architectures. Technially it is also used only for these archs
> but this breaks the build with custom OMAP4 configuration.

...

> Fix the build break by dropping the #ifdef as suggested by Paul Walmsley
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>


Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
