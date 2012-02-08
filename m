From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Feb 2012 15:46:54 -0800
Subject: [PATCH 01/16] ARM: omap: fix oops in arch/arm/mach-omap2/vp.c
 when pmic is not found
In-Reply-To: <20120208183333.GA29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAV6-0006Gj-Di@rmk-PC.arm.linux.org.uk>
 <20120208183333.GA29796@atomide.com>
Message-ID: <20120208234654.GC16877@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120208 10:02]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:05]:
> 
> This is better than Kevin's earlier patch because of the descriptive
> error:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Hmm looks like the patch from Ahilash that Kevin queued has the
also a test for missing uv_to_vsel:

if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel)

So there seems to be more to it than what Russell's patch is
doing.

Regards,

Tony
