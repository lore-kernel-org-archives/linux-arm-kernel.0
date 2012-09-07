From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 7 Sep 2012 10:48:39 +0200
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Message-ID: <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 1, 2012 at 10:16 AM, AnilKumar Ch <anilkumar@ti.com> wrote:
> Adopt pinctrl support to leds-gpio driver based on leds-gpio
> device pointer, pinctrl driver configure SoC pins to GPIO
> mode according to definitions provided in .dts file.

Shouldn't be the interaction with the pinctrl layer left to gpiolib?

Cheers,
Domenico
