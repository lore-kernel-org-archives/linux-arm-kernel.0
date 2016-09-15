From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Sep 2016 14:33:59 +0200
Subject: [PATCH 13/19] pinctrl: st: Remove STiH415/6 SoC pinctrl driver
 support.
In-Reply-To: <1473859677-9231-14-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-14-git-send-email-peter.griffin@linaro.org>
Message-ID: <CACRpkdaqueB4+LJxiqDx9xERYAO=3M3tRgQjafgTqsW+H3eaRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 3:27 PM, Peter Griffin <peter.griffin@linaro.org> wrote:

> STiH415/6 SoC support is being removed from the kernel.
> This patch updates the ST pinctrl driver and removes
> references to these obsolete platforms. As some structures
> referenced by STiH407 based configuration were shared with
> STiH416 we update these names to match the remaining
> supported platform.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <linus.walleij@linaro.org>
> Cc: <linux-gpio@vger.kernel.org>

Patch applied.

Yours,
Linus Walleij
