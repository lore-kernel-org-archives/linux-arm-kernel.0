From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Jul 2013 15:10:59 -0300
Subject: [PATCH 20/22] arm/dts: Add support for the cpuimx51 board from
 Eukrea and its baseboard.
In-Reply-To: <1373900227-341-21-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-21-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5AMA=0Qt_XBYmZXLpPn0ri=JvSV40Qt0CyDNps6GsvAfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Mon, Jul 15, 2013 at 11:57 AM, Denis Carikli <denis@eukrea.com> wrote:

> +i.MX51 Eukrea CPUIMX51 Board
> +Required root node properties:
> +    - compatible = "fsl,eukrea_cpuimx51", "fsl,imx51";
> +

The fsl.txt file contains boards that are developed by Freescale.

The compatible string "fsl,eukrea_cpuimx51" is not correct, as the
cpuimx51 board is not manufactured by Freescale.

You should have used "eukrea" as the manufacturer instead.
