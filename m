From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 17:23:17 +0100
Subject: [PATCH v4 1/6] pinctrl: rockchip: add suspend/resume functions
In-Reply-To: <1413933557-25684-1-git-send-email-zyw@rock-chips.com>
References: <1413933461-25602-1-git-send-email-zyw@rock-chips.com>
 <1413933557-25684-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CACRpkdZhQpCS+S-EA_ehjrpj=uS7bnb4L_OohbnBw5sXfGgaeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 1:19 AM, Chris Zhong <zyw@rock-chips.com> wrote:

> From: Chris <zyw@rock-chips.com>
>
> support suspend/resume of pinctrl, it allows handling sleep mode
> for hogged pins in pinctrl
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

Looks good but I'm delegating to Heiko to collect and review patches
on the Rockchip pin control driver.

I will point out if I see something immediately disturbing.

Yours,
Linus Walleij
