From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 17:45:40 +0200
Subject: [PATCH] ARM: dts: fix PCLK name on Gemini and MOXA ART
In-Reply-To: <20171016142607.11930-1-linus.walleij@linaro.org>
References: <20171016142607.11930-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a0sJa5HTpey+fgOGxFMkfObmJT905Q9y=O3mNAJ47KcKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 4:26 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> These platforms provide a clock to their watchdog, in each
> case this is the peripheral clock (PCLK), so explicitly
> name the clock in the device tree.
>
> Take this opportunity to add the "faraday,ftwdt010"
> compatible as fallback to the watchdog IP blocks.
>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to fixes, thanks!
