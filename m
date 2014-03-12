From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 12 Mar 2014 15:15:47 +0000 (UTC)
Subject: [PATCH 02/10] ARM: OMAP3: fix iva mmu programming issues
In-Reply-To: <1394065459-16409-3-git-send-email-s-anna@ti.com>
References: <1394065459-16409-1-git-send-email-s-anna@ti.com>
 <1394065459-16409-3-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1403121515280.8574@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Mar 2014, Suman Anna wrote:

> The IVA MMU is not functional when used through the hwmod and
> omap_device layers. Add fixes to clockdomain and hwmod data
> to have it functional. The hwmod changes are needed to enable
> the clock, and the SWSUP change is needed to wakeup the domain
> because the power domain is programmed to be in RET, and there
> is no automatic power domain switching to ON.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
