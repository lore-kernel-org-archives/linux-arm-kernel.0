From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 21:54:54 +0100
Subject: [PATCH v6 1/7] pinctrl: rockchip: add suspend/resume functions
In-Reply-To: <1414583525-17395-2-git-send-email-zyw@rock-chips.com>
References: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>
 <1414583525-17395-2-git-send-email-zyw@rock-chips.com>
Message-ID: <CACRpkdbm6q9Y0zqyQpCbVZzprEHcca75r1aC1OEq1HBmEXBj=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 12:51 PM, Chris Zhong <zyw@rock-chips.com> wrote:

> support suspend/resume of pinctrl, it allows handling sleep mode
> for hogged pins in pinctrl
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

As mentioned I expect Heiko to queue this patch with the
other stuff and send the result to me.

Yours,
Linus Walleij
