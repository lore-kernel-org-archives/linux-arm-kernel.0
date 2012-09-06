From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 07 Sep 2012 07:03:53 +0900
Subject: [PATCH v3 1/4] pinctrl: add samsung pinctrl and gpiolib driver
In-Reply-To: <5048DE83.4050203@wwwdotorg.org>
References: <226e01cd8ae6$928010b0$b7803210$%kim@samsung.com>
 <1346826046-30484-1-git-send-email-thomas.abraham@linaro.org>
 <5048DE83.4050203@wwwdotorg.org>
Message-ID: <241701cd8c7b$81022580$83067080$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote:
> 
> On 09/05/2012 12:20 AM, Thomas Abraham wrote:
> > Add a new device tree enabled pinctrl and gpiolib driver for Samsung
> > SoC's. This driver provides a common and extensible framework for all
> > Samsung SoC's to interface with the pinctrl and gpiolib subsystems. This
> > driver supports only device tree based instantiation and hence can be
> > used only on those Samsung platforms that have device tree enabled.
> >
> > This driver is split into two parts: the pinctrl interface and the
> gpiolib
> > interface. The pinctrl interface registers pinctrl devices with the
> pinctrl
> > subsystem and gpiolib interface registers gpio chips with the gpiolib
> > subsystem. The information about the pins, pin groups, pin functions and
> > gpio chips, which are SoC specific, are parsed from device tree node.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Applied this whole series, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
