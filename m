From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 14:06:27 -0600
Subject: [PATCH 08/22] rtc: Add device tree probing to the Gemini driver
In-Reply-To: <20170122121950.10449-1-linus.walleij@linaro.org>
References: <20170122121950.10449-1-linus.walleij@linaro.org>
Message-ID: <20170123200627.uyfdayiuoqbuoxrp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 01:19:50PM +0100, Linus Walleij wrote:
> This adds bindings and simple probing for the Cortina Systems Gemini
> SoC RTC.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> RTC maintainers: please just apply this to the RTC tree when you
> are pleased with it. It is functionally orthogonal to the rest of
> the series and just in a series for context.
> ---
>  Documentation/devicetree/bindings/rtc/cortina,gemini.txt | 14 ++++++++++++++
>  drivers/rtc/rtc-gemini.c                                 |  7 +++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt

Acked-by: Rob Herring <robh@kernel.org>
