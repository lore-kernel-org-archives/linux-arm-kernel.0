From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 09 Mar 2018 15:26:09 -0800
Subject: [GIT PULL] Allwinner clock fixes for 4.16
In-Reply-To: <20180223113120.GA2659@wens.csie.org>
References: <20180223113120.GA2659@wens.csie.org>
Message-ID: <152063796996.113003.6796575742282477127@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chen-Yu Tsai (2018-02-23 03:31:20)
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
> 
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-fixes-for-4.16
> 
> for you to fetch changes up to 5682e268350f9eccdbb04006605c1b7068a7b323:
> 
>   clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops (2018-02-19 08:59:50 +0100)
> 
> ----------------------------------------------------------------
> Allwinner clock fixes for 4.16
> 
> A critical fix for the A31 sunxi-ng clock driver. The CLK_OUT clocks
> had definitions paired with the incorrect type of clk ops. This results
> in a serious oops starting with commit 946797aa3f08 ("clk: sunxi-ng:
> Support fixed post-dividers on MP style clocks"), which exposed the
> incorrect clk ops when it added a new field to the data structures,
> which then nudged the underlying (compatible but incorrect) data
> structures out of alignment.
> 

Thanks. Pulled.
