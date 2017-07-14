From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 14 Jul 2017 17:40:51 -0300
Subject: [PATCH 2/2 v3] ARM: dts: imx7d-sdb: Pass 'enable-gpios' and
In-Reply-To: <1500059114-23677-2-git-send-email-marco.franchi@nxp.com>
References: <1500059114-23677-1-git-send-email-marco.franchi@nxp.com>
 <1500059114-23677-2-git-send-email-marco.franchi@nxp.com>
Message-ID: <CAOMZO5BCiMzpDxQf_25P_y3QfpYS-5ddeCGfRFcR9wJvH5N6bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marco,

On Fri, Jul 14, 2017 at 4:05 PM, Marco Franchi <marco.franchi@nxp.com> wrote:
> Currently the LCD is turned on thanks to the bootloader initialization.
>
> In order to make the kernel to turn on the LCD on is own, pass the
> 'enable-gpios' and 'power-supply' properties.
>
> Also, the GPIO1_IO01 is not used as PWM functionality on this board. It is
> connected to the PWREN pin of connector J14 and has a GPIO function, so
> remove the PWM1 node and change the GPIO1_IO01 IOMUX to GPIO function.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

The word 'power-supply' is missing in the Subject.
