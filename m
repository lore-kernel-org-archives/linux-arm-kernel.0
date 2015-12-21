From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 21 Dec 2015 00:53:13 -0600
Subject: [PATCH V2] ARM: socfpga: dts: Enable MMC support at correct place
 in the DT
In-Reply-To: <1450654581-5070-1-git-send-email-marex@denx.de>
References: <1450654581-5070-1-git-send-email-marex@denx.de>
Message-ID: <5677A1D9.4060909@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/20/2015 05:36 PM, Marek Vasut wrote:
> The socfpga.dtsi explicitly enabled MMC support, but not all boards are
> equiped with an MMC card. There are setups which only have QSPI NOR.
> Therefore, disable the MMC support on socfpga.dtsi level and enable it
> on per-board basis.
> 

Thanks Marek. Applied.

Dinh
