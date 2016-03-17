From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Mar 2016 14:10:58 -0500
Subject: [PATCH 1/4] gpio: Add AXP209 GPIO driver
In-Reply-To: <1457520614-32239-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <1457520614-32239-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160317191058.GA31052@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 11:50:11AM +0100, Maxime Ripard wrote:
> The AXP209 PMIC has a bunch of GPIOs accessible, that are usually used to
> control LEDs or backlight.
> 
> Add a driver for them
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/gpio/gpio-axp209.txt       |  30 ++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpio/Kconfig                               |   6 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-axp209.c                         | 166 +++++++++++++++++++++
>  4 files changed, 203 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-axp209.txt
>  create mode 100644 drivers/gpio/gpio-axp209.c
