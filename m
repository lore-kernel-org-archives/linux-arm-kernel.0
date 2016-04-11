From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Apr 2016 13:21:59 -0700
Subject: [PATCH v5 5/6] ARM: dts: DRA7: Add TBCLK for PWMSS
In-Reply-To: <1457400224-24797-6-git-send-email-fcooper@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-6-git-send-email-fcooper@ti.com>
Message-ID: <20160411202159.GF5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Franklin S Cooper Jr <fcooper@ti.com> [160307 17:24]:
> From: Vignesh R <vigneshr@ti.com>
> 
> tbclk is used by ehrpwm to generate PWM waveform on DRA7 SoC. Add Linux
> clock to control ehrpwm tbclk.
> The TRM says, tbclk is derived from SYSCLKOUT. SYSCLKOUT is nothing but
> ehrpwm functional clock derived from the gateable interface and
> functional clock of PWMSS(l4_root_clk_div).
> Refer AM57x TRM SPRUHZ6E[1], Janurary 2016, Table 29-4 and
> Section 29.2.2.1, Table 29-19 and the NOTE at the end of the table.

Applying this one into omap-for-v4.7/dt thanks.

Tony
