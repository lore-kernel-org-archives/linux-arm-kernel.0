From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Nov 2011 14:30:53 -0700 (MST)
Subject: [PATCH] arm: omap2+: hwmod: fix breakage introduced by
 d6504acd
In-Reply-To: <1320688617-4543-1-git-send-email-balbi@ti.com>
References: <1320688617-4543-1-git-send-email-balbi@ti.com>
Message-ID: <alpine.DEB.2.00.1111071429530.12394@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2011, Felipe Balbi wrote:

> commit d6504acd (OMAP2+: hwmod: remove OMAP_CHIP*) has
> mistakenly added MUSB as a hwmod available only on ES2.0
> of OMAP3430.
> 
> MUSB hwmod has always be available on all OMAP revisions
> since OMAP2430.

Are you sure about this?  I don't see it in my 3430ES1 TRM text.


- Paul
