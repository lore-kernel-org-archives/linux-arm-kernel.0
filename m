From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 20 Dec 2012 17:22:44 +0000 (UTC)
Subject: [PATCH 09/12] ARM: OMAP2+: powerdomain: skip register reads for
 powerdomains known to be on
In-Reply-To: <50D22D0B.3050502@ti.com>
References: <20121209200108.3196.12452.stgit@dusk.lan>
 <20121209200327.3196.27686.stgit@dusk.lan> <50D22D0B.3050502@ti.com>
Message-ID: <alpine.DEB.2.00.1212201722190.3498@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Dec 2012, Jon Hunter wrote:

> My understanding is that for OMAP4 devices, the core power domain may
> not be active the same time as the MPU power domain. The Cortex-A9 has
> the ability to access some peripherals (such as timer, McBSP) via a
> private bus that does not require the core domain to be active. This is
> a difference from OMAP3 devices, where the core would always be on with
> the MPU power domain.

You are absolutely right and I will drop that part from this patch.


- Paul
