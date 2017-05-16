From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 May 2017 08:49:12 -0300
Subject: [PATCH] ARM: dts: imx7: use 3 PWM cells
In-Reply-To: <20170516074013.3571-1-stefan@agner.ch>
References: <20170516074013.3571-1-stefan@agner.ch>
Message-ID: <CAOMZO5AnZq+FU5zoCchxgON7nAfoSs1kEchEXZDkABXo94S2Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 4:40 AM, Stefan Agner <stefan@agner.ch> wrote:
> The PWM driver has now capability to specify the PWM polarity
> which is e.g. for backlight control. Allow to make use of PWM
> polarity by specifying pwm-cells to be 3 in the base dt.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
