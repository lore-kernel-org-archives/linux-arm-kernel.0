From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2016 19:21:41 +0200
Subject: [PATCH 1/4] soc: qcom: add an EBI2 device tree bindings
In-Reply-To: <CAL_JsqJSO4Bco_BJqYFVEQ73_-nm_QeHy=HF3u6bNhxsikOAGw@mail.gmail.com>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <2988918.zNxvaGl6en@wuerfel>
 <CACRpkdZ=HU6j3=Ye4dm=tFU=KmG54bq06KDfxPViWUouOA=jOA@mail.gmail.com>
 <201608291351.12915.arnd@arndb.de>
 <CAL_JsqJPckLGDSiqnspvtP_=t+yZ+0vO-8MxGB6x7poOZiyK+Q@mail.gmail.com>
 <CACRpkdaRPa=tCH2FQUOUzp0Q2YvdLNA7R2y3w==sH40DwJ2vGA@mail.gmail.com>
 <CAL_JsqJSO4Bco_BJqYFVEQ73_-nm_QeHy=HF3u6bNhxsikOAGw@mail.gmail.com>
Message-ID: <CACRpkdbZdRc+75YKTGLSogK6zqnR9crks3-YYmMFOLsxHbk2dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 4:06 PM, Rob Herring <robh+dt@kernel.org> wrote:
> [Me]
>> That is very close to how
>> Documentation/devicetree/bindings/bus/imx-weim.txt
>> drivers/bus/imx-weim.c
>> does things, just with the additional property arrays.
>
> Maybe so, but I'm trying to bring some consistency here, so I'd
> suggest looking at newer ones like atmel IIRC.

The Uniphier bindings also look like this and it's the most recent
bus driver ...
Documentation/devicetree/bindings/bus/uniphier-system-bus.txt

But OK it's probably best to follow an example so I get it the way
you prefer. Which binding and driver is that?

There's no Atmel stuff in Documentation/devicetree/bindings/bus/
nor drivers/bus from what I can tell, so just point out what you're
referring to here and I'll do my best to follow that example.

Yours,
Linus Walleij
