From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 20 Feb 2016 09:57:27 -0200
Subject: [PATCH 3/4] ARM: dts: imx6ul: Add GPMI nand controller support
In-Reply-To: <1455963652-24618-4-git-send-email-michael@amarulasolutions.com>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
 <1455963652-24618-4-git-send-email-michael@amarulasolutions.com>
Message-ID: <CAOMZO5DTmG7Umt+H20r+tZi9zZhsK=eoPbHOBO3iwvM2GXXLgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sat, Feb 20, 2016 at 8:20 AM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Add support for GPMI nand controller.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi          | 33 +++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 10 ++++++++++
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h |  6 ++++--

It would be better to split the dts and mtd parts in two patches.
