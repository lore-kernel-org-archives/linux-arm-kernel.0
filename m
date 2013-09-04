From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Sep 2013 07:42:16 +0200
Subject: [PATCH V3 1/4] mmc: mmci: Adapt to new pinctrl handling
In-Reply-To: <1378200576-13413-2-git-send-email-ulf.hansson@linaro.org>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
 <1378200576-13413-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdbPLPWO4PjDRzPE-FneSYPMtNtbVOSyzNxsmhC7ni6=tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 3, 2013 at 11:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> There is no need for every driver to fetch a pinctrl handle and to
> select the default state. Instead this is handled by the device driver
> core, thus we can remove this piece of code from mmci.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
