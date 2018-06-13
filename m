From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Jun 2018 11:10:35 +0200
Subject: [PATCH 3/3] rtc: ftrtc010: let the core handle range
In-Reply-To: <20180604141528.15635-3-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
 <20180604141528.15635-3-alexandre.belloni@bootlin.com>
Message-ID: <CACRpkdabaH2yiYNnQHBru=-Snb3Eeni2eDAa9mjsa-3DqMC72g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> The current range handling is highly suspicious. Anyway, let the core
> handle it.

Hmmm. I have datasheets, do you need some input about the hardware?
Something I should patch?

> The RTC has a 32 bit counter on top of days + hh:mm:ss registers.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
