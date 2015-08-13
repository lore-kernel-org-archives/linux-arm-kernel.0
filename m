From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 16:10:52 +0200
Subject: [PATCH v5 1/2] clk: rockchip: add pclk_pd_pmu to the list of
 rk3288 critical clocks
In-Reply-To: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
References: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
Message-ID: <CACRpkdZpk+djjb08Ls0CQdCD=wmNYQSDTMWwgJs_CMGYWXpoQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 12:12 PM, Lin Huang <hl@rock-chips.com> wrote:

> From: Heiko Stuebner <heiko@sntech.de>
>
> pclk_pd_pmu needs to keep running and with the upcoming gpio clock
> handling this is not always the case anymore. So add it to the list
> of critical clocks for now.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v5:
> - Add From: Heiko Stuebner <heiko@sntech.de>
> - Add Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied to the pinctrl tree with Doug's reviwe tag and
Stephen B's ACK.

Yours,
Linus Walleij
