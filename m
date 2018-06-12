From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 12 Jun 2018 01:08:09 -0700
Subject: [clk:clk-bcm-stingray 1/2] drivers/clk/bcm/clk-sr.c:217:3: error:
 'BCM_SR_LCPLL0_SATA_REF_CLK' undeclared here (not in a function);
 did you mean 'BCM_SR_LCPLL0_SATA_REFN_CLK'?
In-Reply-To: <016e740bcf20db8fa753c6686812ce76@mail.gmail.com>
References: <201806021742.e6HPCQOb%fengguang.wu@intel.com>
 <016e740bcf20db8fa753c6686812ce76@mail.gmail.com>
Message-ID: <152879088933.16708.2618330114850661561@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ray Jui (2018-06-06 14:00:06)
> Hi Stephen,
> 
> I'd like to confirm this kbuild error is caused by changing of the defines
> in the header.
> 
> That is, kbuild test should pass with 2/2 patch.
> 
> If my understanding is incorrect and this requires any further action,
> please let me know.

Don't think so. Linus merged clk-next over the weekend. Either I applied
the patches in the wrong order, or you sent them in the wrong order. In
the future, please compile test each patch in isolation. I do that
sometimes, but not always as it's still a manual process for me. I need
to update my scripts to make that better, which I'll do shortly.
