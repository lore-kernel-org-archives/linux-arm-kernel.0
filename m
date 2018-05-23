From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 23 May 2018 10:56:13 -0300
Subject: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
In-Reply-To: <20180519140202.3449e3c1@jawa>
References: <20180509153428.1440-1-lukma@denx.de>
 <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
 <20180519140202.3449e3c1@jawa>
Message-ID: <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Sat, May 19, 2018 at 9:02 AM, Lukasz Majewski <lukma@denx.de> wrote:

> After removing imx53-kp-ddc and imx53-kp-common iomux subnodes I do see
> following errors in the dmesg (v4.17-rc5):
>
> imx53-pinctrl 53fa8000.iomuxc: function 'iomuxc' not supported
> imx53-pinctrl 53fa8000.iomuxc: invalid function iomuxc in map table

Could you please investigate this error?

I have just tried the following change on a imx53-qsb:
http://code.bulix.org/ik01yu-339697

and it works as expected:
# dmesg  | grep iomux
[    0.100046] imx53-pinctrl 53fa8000.iomuxc: initialized IMX pinctrl driver
