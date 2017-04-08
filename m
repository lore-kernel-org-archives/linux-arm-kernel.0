From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 8 Apr 2017 14:51:48 +0800
Subject: [PATCH 0/5] arm64: dts: hisi: add NIC, RoCE and SAS support for
 hip07
In-Reply-To: <1491530876-109791-1-git-send-email-xuwei5@hisilicon.com>
References: <1491530876-109791-1-git-send-email-xuwei5@hisilicon.com>
Message-ID: <58E88884.2090702@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On 2017/4/7 10:07, Wei.Xu wrote:
> This patch series adds Mbigen, NIC, RoCE and SAS nodes for the hip07
> SoC and enables the NIC, RoCE and SAS on the hip07 d05 board.
>
> Wei Xu (5):
>    arm64: dts: hisi: add mbigen nodes for the hip07 SoC
>    arm64: dts: hisi: add network related nodes for the hip07 SoC
>    arm64: dts: hisi: add RoCE nodes for the hip07 SoC
>    arm64: dts: hisi: add SAS nodes for the hip07 SoC
>    arm64: dts: hisi: enalbe the NIC and SAS for the hip07-d05 board
>
>   arch/arm64/boot/dts/hisilicon/hip07-d05.dts |  24 ++
>   arch/arm64/boot/dts/hisilicon/hip07.dtsi    | 479 ++++++++++++++++++++++++++++
>   2 files changed, 503 insertions(+)
>
After removed the PCIe node in the patch 5, the series has been applied 
to the hisilicon arm64
dt tree since this series patches just to add the nodes and the binding 
has been reviewed before.

Best Regards,
Wei
