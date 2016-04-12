From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Apr 2016 22:04:07 -0300
Subject: [PATCH v2] ARM: dts: imx6: Add dts for Embest MarS Board
In-Reply-To: <1460420743-30883-1-git-send-email-sergio.prado@e-labworks.com>
References: <1460420743-30883-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <CAOMZO5D80VWGad7Lz+Crp8on5xLJzHDXL88FBh7x8d4Mc2XKww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergio,

On Mon, Apr 11, 2016 at 9:25 PM, Sergio Prado
<sergio.prado@e-labworks.com> wrote:
> Embest MarS Board [1] is a multi-core platform based on Freescale i.MX6
> Cortex-A9 Dual Core, running up to 1GHz with 1 GB of RAM, 4GB of eMMC
> and with a 4MB SPI flash.
>
> [1] http://www.embest-tech.com/shop/star/marsboard.html
>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>

Can't the Mars board re-use arch/arm/boot/dts/imx6dl-riotboard.dts ?
