From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 14:24:28 +0200
Subject: [PATCH v5 2/2] pinctrl: rockchip: only enable gpio clock when it
 setting
In-Reply-To: <1439287924-6988-2-git-send-email-hl@rock-chips.com>
References: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
 <1439287924-6988-2-git-send-email-hl@rock-chips.com>
Message-ID: <CACRpkda0FXz1dpdS-wLRNmkt1KBESMyCWKMMa0ArH9Z-L=i_sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 12:12 PM, Lin Huang <hl@rock-chips.com> wrote:

> gpio can keep state even the clock disable, for save power
> consumption, only enable gpio clock when it setting
>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes in v5:
> -rebase patch

Patch applied with Doug's test tags etc.

Yours,
Linus Walleij
