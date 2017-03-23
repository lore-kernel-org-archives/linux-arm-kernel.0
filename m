From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 23 Mar 2017 16:27:20 -0700
Subject: [GIT PULL] Allwinner clock fixes for 4.11
In-Reply-To: <20170320095004.4vd2edph2u7kxi7l@lukather>
References: <20170320095004.4vd2edph2u7kxi7l@lukather>
Message-ID: <20170323232720.GA25840@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20, Maxime Ripard wrote:
> Hi Mike, Stephen,
> 
> Please pull the following patches for one of the 4.11's rc
> 
> Thanks!
> Maxime
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clk-fixes-for-4.11
> 
> for you to fetch changes up to b467e08a15563dede0d37d3233baa24fb97a7310:
> 
>   clk: sunxi-ng: fix recalc_rate formula of NKMP clocks (2017-03-20 10:34:05 +0100)
> 
> ----------------------------------------------------------------
> Allwinner clock fixes for 4.11
> 
> A few fixes for a bunch of clocks on a few SoCs. The most important one is
> probably one that fixes the NKMP clock frequency calculation and could end
> up with clocking the CPU frequency to out of bounds rates.
> 

Thanks. Pulled

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
