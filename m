From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Jun 2012 20:39:57 -0300
Subject: [Patch v5 11/13] ARM: dts: imx6q-sabrelite: add usb devices
In-Reply-To: <1339590863-10564-12-git-send-email-richard.zhao@freescale.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-12-git-send-email-richard.zhao@freescale.com>
Message-ID: <CAOMZO5AzxAt_mVEFCXJL8e7kqBCwGgHtMB7N3Rxfc2phNRXCyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard/Shawn,

On Wed, Jun 13, 2012 at 9:34 AM, Richard Zhao
<richard.zhao@freescale.com> wrote:

> + ? ? ? ? ? ? ? ? ? ? ? iomuxc at 020e0000 {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pinctrl-names = "default";
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pinctrl-0 = <&pinctrl_gpio_hog>;

I would like to use this same concept on mxs, which does not have a
"iomuxc" driver like imx6.

To which driver should I glue the 'pinctrl-0 = <&pinctrl_gpio_hog>;'  on mxs?
