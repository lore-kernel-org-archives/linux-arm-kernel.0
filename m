From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 07 Sep 2016 12:07:39 -0700
Subject: [PATCH 1/2] pinctrl: meson-gxbb: add the pins for the
 SDIO/sd_emmc_a controller
In-Reply-To: <CACRpkdbPVeUA+BSPgQ1XmFJw_J6-V_2BM9h3kO2yq-vUfySsGQ@mail.gmail.com>
 (Linus Walleij's message of "Wed, 7 Sep 2016 16:24:29 +0200")
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
 <20160828164725.19429-2-martin.blumenstingl@googlemail.com>
 <CACRpkdbPVeUA+BSPgQ1XmFJw_J6-V_2BM9h3kO2yq-vUfySsGQ@mail.gmail.com>
Message-ID: <7hk2enttok.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Sun, Aug 28, 2016 at 6:47 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>
>> sd_emmc_a is used a controller for the SDIO modules. This adds the pin
>> configuration for the SDIO controller.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> No reply from maintainers, but you obviously know what you're doing so
> patch applied.

Oh, I thought Neil already responded, but I'm not seeing it now.  This
patch is missing the SDIO IRQ line.

Martin can you respin?

Sorry for the lag, I'm still catching up after some vacation,

Kevin
