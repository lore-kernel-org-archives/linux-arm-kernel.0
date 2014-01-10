From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 10 Jan 2014 11:47:33 -0800
Subject: [PATCH] ARM: msm_defconfig: Update for multi-platform
In-Reply-To: <1389381128-28280-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Fri, 10 Jan 2014 11:12:08 -0800")
References: <1389381128-28280-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <87d2jzaaay.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> ARCH_MSM is a hidden config option now so this defconfig needs to
> be updated to select ARCH_MSM_DT instead. While we're here,
> remove dead symbols (SSBI), drop selected symbols (ZRELADDR,
> PHYLIB, USB_PHY) and enable the MSM random driver (HW_RANDOM_MSM).
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Applied to next/soc, merged into for-next and pushed out.

Thanks for the quick fixup.

Kevin
