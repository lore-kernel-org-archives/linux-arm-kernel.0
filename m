From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 3 Aug 2016 17:25:29 -0700
Subject: [PATCH v2 0/4] pwm: Add Amlogic Meson SoC PWM Controller
In-Reply-To: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
References: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAOi56cVGRpSeAVwaATkx8Q2wz9hxocq6095opJQZucfDML2wSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Sun, Jul 10, 2016 at 2:27 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Add support for the PWM controller found in Amlogic Meson SoCs.
> This controller provides a dual PWM output with 4 selectable clock source
> and a two level divider to achieve a better PWM range.
>
> Currently Meson8b and GXBB SoCs are supported.
>
> Changes since v1 at http://lkml.kernel.org/r/1466173784-15625-1-git-send-email-narmstrong at baylibre.com :
> - fix meson8b dtsi

Gentle reminder ping on this series.

Thanks,

Kevin
