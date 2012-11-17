From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 17 Nov 2012 21:12:38 +0100
Subject: [PATCH 3/3] ARM: dts: cfa10049: Add PCA9555 GPIO expander to the
 device tree
In-Reply-To: <1352394113-19513-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1352394113-19513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1352394113-19513-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdazguB2BvhMTWz+0JLcH7tC8nc75U6bVMHS2ZYmt6i7=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2012 at 6:01 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Add the GPIO expander found on the i2c1 bus, behind the muxer to the
> device tree.
>
> This gpio expander will be used to get tachymeters values and data ready
> interruptions from the nuvoton NAU7802 ADCs.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This does not apply to the GPIO tree, and I have no ACK from the platform
maintainer so apply it wherever you see fit.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
