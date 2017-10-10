From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Oct 2017 22:09:52 +0200
Subject: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
In-Reply-To: <20170812184318.10144-12-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-12-linus.walleij@linaro.org>
Message-ID: <CACRpkdbJhTmSZDudJCb_8nOfk6802Z8Op2+gjY9vdDT9Cg+6eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 8:43 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds the PCLK clock to the Aspeed watchdog blocks.
> I am not directly familiar with the Aspeed clocking, but
> since the IP is derived from Faraday FTWDT010 it probably
> has the ability to run the watchdog on the PCLK if
> desired so to obtain the frequency from it, it needs to
> be present in the device tree, and for completeness the
> PCLK should also be referenced and enabled anyways.
>
> Take this opportunity to add the "faraday,ftwdt010"
> compatible as fallback to the watchdog IP blocks.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Joel could you merge this through the Aspeed tree? I think
the compatible string is completely uncontroversial
(binding ACKed) to add and all should just work fine so we
can slap in "EXTCLK" later as well.

Yours,
Linus Walleij
