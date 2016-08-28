From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 28 Aug 2016 18:33:03 +0200
Subject: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
In-Reply-To: <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCA3PoR_=+f8aU-Trg8uKWWXkkBOtrQUaXbdsb8E-fdM0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 5:36 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Add support for the PWM controller found in the Amlogic SoCs.
> This driver supports the Meson8b and GXBB SoCs.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I could enable the AP6330 SDIO wifi module with this on my
meson-gxbb-vega-s95-meta clone, which uses pwm_e to generate the LPO
clock for the wifi module (see [0] for the corresponding patches).
So thank you Neil, and:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


[0] https://github.com/xdarklight/linux/tree/meson-gxbb-integration-4.8-20160828
