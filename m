From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Mar 2016 14:32:25 -0700
Subject: [PATCH v2] ARM: dts: dra7: Correct clock tree for sys_32k_ck
In-Reply-To: <20160330211828.GE9329@atomide.com>
References: <1457957001-720-1-git-send-email-j-keerthy@ti.com>
 <20160330211828.GE9329@atomide.com>
Message-ID: <20160330213224.GH9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160330 14:19]:
> * Keerthy <j-keerthy@ti.com> [160314 05:04]:
> > This is w.r.t J6/J6eco: 32clk is pseudo (erratum i856) - clock source.
> > Errata i856 for the AM572x (DRA7xx) points out that the 32.768KHz external
> > crystal is not enabled at power up. Instead the CPU falls back to using
> > an emulation for the 32KHz clock which is SYSCLK1/610.  SYSCLK1 is usually
> > 20MHz on boards so far (which gives an emulated frequency of 32.786KHz)
> 
> Thanks applying into omap-for-v4.6/fixes.

Actually let's wait a review from Tero on this one, not sure
about the pseudo clock naming here. So dropping for now.

Regards,

Tony
