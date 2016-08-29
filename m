From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Aug 2016 15:42:55 +0200
Subject: [PATCH 1/4] soc: qcom: add an EBI2 device tree bindings
In-Reply-To: <CACRpkdaRPa=tCH2FQUOUzp0Q2YvdLNA7R2y3w==sH40DwJ2vGA@mail.gmail.com>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <CAL_JsqJPckLGDSiqnspvtP_=t+yZ+0vO-8MxGB6x7poOZiyK+Q@mail.gmail.com>
 <CACRpkdaRPa=tCH2FQUOUzp0Q2YvdLNA7R2y3w==sH40DwJ2vGA@mail.gmail.com>
Message-ID: <201608291542.55387.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 August 2016, Linus Walleij wrote:
> Gnah. Each chipselect can (in theory) house several memory-mapped
> devices at different offsets. Like two ethernet controllers. It gets a bit
> weird.

How theoretical is that setup though? From looking at other external
bus interfaces that we support, I can't find anyone actually doing
this.

	Arnd
