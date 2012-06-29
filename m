From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 29 Jun 2012 16:42:44 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2: twl-common: fix compiler warnings
In-Reply-To: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
References: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1206291642290.2338@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jun 2012, Tero Kristo wrote:

> OMAP2 does not use the external voltage controller code for TWL, and
> thus OMAP2 only compilation generates following warnings:
> 
> arch/arm/mach-omap2/twl-common.c:51: warning: 'twl_set_voltage' defined but not used
> arch/arm/mach-omap2/twl-common.c:57: warning: 'twl_get_voltage' defined but not used
> 
> This patch moves the code in question behind ARCH specific flags and
> eliminates these warnings.
> 
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks Tero, looks okay to me.  I guess Kevin or Tony should queue this 
one.


- Paul
