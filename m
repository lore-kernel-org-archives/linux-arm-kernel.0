From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Sep 2014 17:20:55 -0700
Subject: [PATCH] ARM: omap: Remove stray ARCH_HAS_OPP references
In-Reply-To: <540B15E1.6090604@ti.com>
References: <1409998456-28066-1-git-send-email-broonie@kernel.org>
 <540B15E1.6090604@ti.com>
Message-ID: <20140909002054.GE10785@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140906 07:11]:
> On 09/06/2014 05:14 AM, Mark Brown wrote:
> >OPP is now a normal kernel library selected by its users rather than a
> >feature that architectures need to enable so ARCH_HAS_OPP serves no
> >function any more - remove the selects.
> >
> >Signed-off-by: Mark Brown <broonie@kernel.org>
... 
 
> Acked-by: Nishanth Menon <nm@ti.com>

Applying into omap-for-v3.18/soc thanks.

Tony 
