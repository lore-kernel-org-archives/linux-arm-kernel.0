From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 06 Jul 2012 12:07:47 +0200
Subject: [PATCH] ARM: OMAP2: twl-common: fix compiler warnings
In-Reply-To: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
References: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
Message-ID: <4FF6B8F3.8010501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On 06/28/2012 12:49 PM, Tero Kristo wrote:
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

I did sent similar patch:
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg70432.html

Tony applied it to fixes I think already.

-- 
P?ter
