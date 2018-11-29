From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 29 Nov 2018 12:02:22 +0100
Subject: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c
 controller
In-Reply-To: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
Message-ID: <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-11-29 at 18:59 +0800, Jian Hu wrote:
> 1)Add G12A SoC i2c compatible string in dt-bindings.
> 2)Add compatible and data for G12A I2C controller driver.
> 
> Jian Hu (2):
>   dt-bindings: i2c: meson: add Meson G12A SoC i2c compatible string
>   i2c: meson: add support for Meson G12A SoC I2C controller

Looks to me that the g12a is compatible with the axg. What is the point of
adding this new compatible string ?

> 
>  Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
>  drivers/i2c/busses/i2c-meson.c                      | 5 +++++
>  2 files changed, 6 insertions(+)
> 
