From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 Jan 2015 07:39:20 +0000 (UTC)
Subject: [PATCH 0/2] arm64: first set of Kconfig patches for Tegra132
 support
In-Reply-To: <20150107110738.GF7485@arm.com>
References: <20150107081638.14381.42444.stgit@dusk.lan>
 <20150107110738.GF7485@arm.com>
Message-ID: <alpine.DEB.2.02.1501072151470.28771@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, 7 Jan 2015, Will Deacon wrote:

> Whilst I'm happy to take the second patch for 3.20 (getting those
> dependencies building and keeping them building is a Good Thing), can we
> hold off on the first patch until it's not broken? Having an unconditional
> depends on BROKEN isn't really that useful.

I reflected on this when preparing the patches.  It seemed to me that the 
CONFIG_BROKEN approach was slightly preferable.  If initial support for 
CONFIG_ARCH_TEGRA is merged, there will be a base set of mainline Kconfig 
directives in mainline for others to use when working on support for 
future Tegra chips, such as the X1.  It also moves mainline slightly 
closer to Tegra132 support than it would be without the patch.  At this 
point in time in my life, I've come to appreciate the incremental "baby 
step" approach ;-)

That written, the difference between the two approaches is rather minimal.  
So ultimately I'm fine with whatever you and Catalin want to do.


regards,

- Paul
