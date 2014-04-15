From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 Apr 2014 01:13:19 -0300
Subject: [PATCH] ARM: imx: Remove mx51_babbage board file
In-Reply-To: <1396624379-13315-1-git-send-email-festevam@gmail.com>
References: <1396624379-13315-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5DpJ+kpn86W88Qa2n9i049AQYAz=atoMdjfHNaoVEmk6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Fri, Apr 4, 2014 at 12:12 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> The device tree version for the babbage board (imx51-babbage.dtb) has a more
> complete support than the board file version, so remove the board file source
> code.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Hi Eric,
>
> Do you think we could remove CPUIMX51SD board file well?
>
> If so, then this would allow us to make imx51 to be device tree only (like
> mx53 and mx6).

Looking at mach-imx51cpusd.c the only support missing on the device
tree version is the mcp2515 node (which has dt support in place).

Do you plan to add mcp2515 in the dts file so that we could remove
mach-imx51cpusd.c and convert mx51 to a dt-only platform?

Regards,

Fabio Estevam
