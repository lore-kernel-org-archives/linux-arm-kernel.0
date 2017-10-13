From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Oct 2017 14:05:08 +0200
Subject: [PATCH 1/4] ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet
In-Reply-To: <20171004185857.24510-2-bjorn.andersson@linaro.org>
References: <20171004185857.24510-1-bjorn.andersson@linaro.org>
 <20171004185857.24510-2-bjorn.andersson@linaro.org>
Message-ID: <CACRpkdba8+NibBQ35Yupwy6aFcHwbyoF+gw_ZyYsc1=jAt0kpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 8:58 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
> This adds a basic DTS file for the Sony Xperia Z2 Tablet, containing
> definitions for regulators, eMMC/SD-card, USB, WiFi, Touchscreen,
> charger, backlight, coincell and buttons.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This looks like a nice start to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Just bluetooth, audio and a panel driver for the graphics and
you're there, right? Piece if cake ;)

Yours,
Linus Walleij
