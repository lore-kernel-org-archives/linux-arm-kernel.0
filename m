From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 11 Oct 2012 14:44:58 +0100
Subject: [PATCH 0/8] clk: ux500: Fixup smp_twd clk for clk notifiers
In-Reply-To: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121011134458.GB15428@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Patches are based on Linus Torvalds tree with latest commit as of okt 10.

Hmm... I get:

Applying: clk: ux500: Support for prcmu_scalable_rate clock
error: drivers/clk/ux500/clk-prcmu.c: does not exist in index
error: drivers/clk/ux500/clk.h: does not exist in index
Patch failed at 0001 clk: ux500: Support for prcmu_scalable_rate clock

So when did drivers/clk/ux500/* arrive? 

Or is it still sitting in your tree?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
