From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2012 21:17:37 +0200
Subject: [PATCH] i2c-nomadik: Fixup clock handling
In-Reply-To: <1348154447-3815-1-git-send-email-ulf.hansson@stericsson.com>
References: <1348154447-3815-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdZZ-gNBi7EDwhXHawmzPD9dE8wo9voX-MJ7CYQ058k-Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 5:20 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Philippe Begnic <philippe.begnic@stericsson.com>
>
> Make sure to clk_prepare as well as clk_enable.

Looks correct. xfer() is slowpatch so we might as well call
prepare/unprepare functions there.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
