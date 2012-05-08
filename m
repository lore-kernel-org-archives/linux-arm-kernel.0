From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 09:12:12 -0700
Subject: [RFC PATCH 4/4] ARM: OMAP2+: CLEANUP: Add new config option
 for different DPLL features
In-Reply-To: <1336489364-19200-5-git-send-email-hvaibhav@ti.com>
References: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
 <1336489364-19200-5-git-send-email-hvaibhav@ti.com>
Message-ID: <20120508161212.GX5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120508 08:10]:
> This patch cleans up dpll_data structure, making structure
> fields definition based on feature availability for given SoC,
> managed using Kconfig rules.
> 
> SOC_HAS_DPLL_IDLE: idle state
> SOC_HAS_DPLL_RECAL: recalibration capability
> SOC_HAS_DPLL_DCO_SEL: dco selection
> SOC_HAS_DPLL_SDDIV: sigma-delta div factor
> SOC_HAS_DPLL_FREQSEL: frequency selection

These too should be SOC_HAS_OMAPXYZ_DPLL_IDLE etc.

Regards,

Tony
