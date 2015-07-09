From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Jul 2015 17:44:31 -0700
Subject: [PATCH 0/2] Add MT8173 MMPLL change rate support
In-Reply-To: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <559DC3EF.90401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2015 01:37 AM, James Liao wrote:
> MT8173 MMPLL frequency settings are different from common PLLs.
> It needs different post divider settings for some ranges of frequency.
> This patch add support for MT8173 MMPLL frequency setting, includes:
>
> 1. Add div-rate table for PLLs.
> 2. Increase the max ost divider setting from 3 (/8) to 4 (/16).
> 3. Write postdiv and pcw settings at the same time.
>
> James Liao (2):
>   clk: mediatek: Fix PLL registers setting flow
>   clk: mediatek: Add MT8173 MMPLL change rate support
>

Are these fixing regressions in 4.2-rc1? I don't see any "Fixes:" tag so
it's not clear and makes me want to defer these until v4.3. Furthermore,
the subject starts with "Add" so it sounds like a new feature.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
