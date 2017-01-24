From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 24 Jan 2017 18:48:39 +0100
Subject: [PATCH 08/22] rtc: Add device tree probing to the Gemini driver
In-Reply-To: <20170122121950.10449-1-linus.walleij@linaro.org>
References: <20170122121950.10449-1-linus.walleij@linaro.org>
Message-ID: <20170124174839.xn6sdgzhv4neauel@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/2017 at 13:19:50 +0100, Linus Walleij wrote :
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
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
