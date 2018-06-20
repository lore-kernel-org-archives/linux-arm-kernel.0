From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Jun 2018 07:50:53 -0300
Subject: [PATCH] ARM: dts: imx7d-sdb: Restore pwm backlight support
In-Reply-To: <c328d3e13702fa624febe08d7cd68df5b82b8c30.1529490998.git.leonard.crestez@nxp.com>
References: <c328d3e13702fa624febe08d7cd68df5b82b8c30.1529490998.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5AJgSPqdLjnAiga-gExUeonkUD0jBsfb_L9n3KF8rbwTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 7:41 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> This was removed in commit 5eaeaccdaedb ("ARM: dts: imx7d-sdb: Pass
> 'enable-gpios' and 'power-supply' properties") with a note claiming that
> GPIO1_IO01 is connected to a pin labeled as "PWREN" on the connector.
>
> Despite that label this pin does actually work as a PWM controlling
> brightness. So restore pwm functionality.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Yes, it seems to me that the PWM functionality has been removed by mistake:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
