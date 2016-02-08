From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 8 Feb 2016 14:15:08 -0800
Subject: [PATCH] clk: meson: Fix meson_clk_register_clks() signature type
 mismatch
In-Reply-To: <1454879583-27036-1-git-send-email-afaerber@suse.de>
References: <1454879583-27036-1-git-send-email-afaerber@suse.de>
Message-ID: <20160208221508.GT4848@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07, Andreas F?rber wrote:
> As preparation for arm64 based mesongxbb, which pulls in this code once
> enabling ARCH_MESON, fix a size_t vs. unsigned int type mismatch.
> The loop uses a local unsigned int variable, so adopt that type,
> matching the header.
> 
> Fixes: 7a29a869434e ("clk: meson: Add support for Meson clock controller")
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---

Applied to clk-next. It would have been nice to have the
compilation error though

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
