From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 18 Apr 2012 03:08:33 -0600 (MDT)
Subject: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
In-Reply-To: <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com>
 <4F8E76C3.7080803@ti.com>
 <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1204180307530.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Apr 2012, Paul Walmsley wrote:

> Sounds to me like the right time to make this change for OMAP4 is when the 
> call to omap2_clk_disable_clkdm_control() is removed from 
> clock44xx_data.c.

Sorry, this should have read "when the call to 
omap2_clk_disable_clkdm_control() is _uncommented_"


- Paul
