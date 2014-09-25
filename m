From: b10716@freescale.com (Laurentiu Tudor)
Date: Thu, 25 Sep 2014 15:55:47 +0300
Subject: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
In-Reply-To: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <542410D3.2060507@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingchang,

On 09/23/2014 09:46 AM, Jingchang Lu wrote:
> The IP is shared by PPC and ARM, this renames it to qoriq for better
> represention, and this also adds the CLK_OF_DECLARE support for being
> initialized by of_clk_init() on ARM.
> 

I think you need to also update drivers/cpufreq/Kconfig.powerpc
to use the renamed config option.

---
Best Regards, Laurentiu
