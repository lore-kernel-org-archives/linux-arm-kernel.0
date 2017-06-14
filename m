From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Jun 2017 16:50:42 -0700
Subject: [GIT PULL] Allwinner clock fixes for 4.12
In-Reply-To: <20170614192119.xktlt4o5puje2pdu@flea.home>
References: <20170614192119.xktlt4o5puje2pdu@flea.home>
Message-ID: <20170614235042.GF20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14, Maxime Ripard wrote:
> Hi Mike, Stephen,
> 
> Please pull the following patches for 4.12
> 
> Thanks!
> Maxime
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-fixes-for-4.12
> 
> for you to fetch changes up to d85da227c3ae43d9ca513d60f244213cb4e55485:
> 
>   clk: sunxi-ng: a64: Export PLL_PERIPH0 clock for the PRCM (2017-05-31 21:57:30 +0200)
> 
> ----------------------------------------------------------------
> Allwinner clock fixes for 4.12
> 
> Some fixes that fix some bindings that went in 4.12, fix a few reset and
> clock offsets and a build error fix
> 

The last few don't have any Fixes: tag. Is that because they
aren't fixes for anything in the tree? I pulled it, but I'm
second guessing it all.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
