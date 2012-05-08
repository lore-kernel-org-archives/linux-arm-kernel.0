From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 10:26:57 -0700
Subject: [RFC PATCH 4/4] ARM: OMAP2+: CLEANUP: Add new config option
 for different DPLL features
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA1AF65@DBDE01.ent.ti.com>
References: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
 <1336489364-19200-5-git-send-email-hvaibhav@ti.com>
 <20120508161212.GX5088@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA1AF65@DBDE01.ent.ti.com>
Message-ID: <20120508172657.GY5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120508 10:28]:
> On Tue, May 08, 2012 at 21:42:12, Tony Lindgren wrote:
> > * Vaibhav Hiremath <hvaibhav@ti.com> [120508 08:10]:
> > > This patch cleans up dpll_data structure, making structure
> > > fields definition based on feature availability for given SoC,
> > > managed using Kconfig rules.
> > > 
> > > SOC_HAS_DPLL_IDLE: idle state
> > > SOC_HAS_DPLL_RECAL: recalibration capability
> > > SOC_HAS_DPLL_DCO_SEL: dco selection
> > > SOC_HAS_DPLL_SDDIV: sigma-delta div factor
> > > SOC_HAS_DPLL_FREQSEL: frequency selection
> > 
> > These too should be SOC_HAS_OMAPXYZ_DPLL_IDLE etc.
> > 
> 
> Thanks Tony, I will change the option accordingly.
> Do you have any further comments on this series? If, no, I will change the 
> option name and submit immediately.

Thanks, looks OK to me otherwise.

Tony
