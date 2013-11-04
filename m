From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Nov 2013 13:05:19 +0100
Subject: [PATCH 1/1] pinctrl: imx: fix using pin->input_val wrongly
In-Reply-To: <1382940076-11898-1-git-send-email-peter.chen@freescale.com>
References: <1382940076-11898-1-git-send-email-peter.chen@freescale.com>
Message-ID: <CACRpkdboYNgLPh0=HiMyd6e21xjruwzb1PqP69_hL3Ds+wun8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 7:01 AM, Peter Chen <peter.chen@freescale.com> wrote:

> The commit: "pinctrl: imx: Use struct type for pins" relaced
> pin->input_reg by pin->input_val wrongly, fix it at this commit.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Patch applied with Sascha's ACK.

Yours.
Linus Walleij
