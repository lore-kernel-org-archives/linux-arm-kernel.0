From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 6 Sep 2016 17:52:08 -0700
Subject: [PATCH] clk: meson-gxbb: Export PWM related clocks for DT
In-Reply-To: <1471870177-10609-1-git-send-email-narmstrong@baylibre.com>
References: <1471870177-10609-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160907005208.GS12510@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22, Neil Armstrong wrote:
> Add the PWM related clocks in order to be referenced as PWM source
> clocks.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

With some more thought, it should go through whatever tree takes
the dts changes. Conflicts in these header files should be
managed by the same person and that person is the platform
maintainer.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
