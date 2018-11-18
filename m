From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 18 Nov 2018 15:04:27 +0100
Subject: [PATCH v3 2/3] soc: amlogic: Add Meson Clock Measure driver
In-Reply-To: <20181118135024.30720-3-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
 <20181118135024.30720-3-narmstrong@baylibre.com>
Message-ID: <CAFBinCBSoXtUtXmvokp9c+E=gQV9VNcqG0VjvPmbKBfngZ8Evg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 2:50 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> The precision is determined by stepping into the duration until the counter
> overflows.
> The debugfs slows a pretty summary and each clock can be measured
> individually aswell.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I have successfully tested it on Odroid-C1:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
