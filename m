From: liwei213@huawei.com (liwei (CM))
Date: Mon, 8 Jan 2018 01:41:38 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjcgMC81XSBzY3NpOiB1ZnM6IGFkZCB1ZnMgZHJp?=
 =?utf-8?Q?ver_code_for_Hisilicon_Hi3660_SoC?=
In-Reply-To: <127f93dd-29c8-8cfc-9b02-5dc72609a272@linaro.org>
References: <20180106095117.67907-1-liwei213@huawei.com>
 <127f93dd-29c8-8cfc-9b02-5dc72609a272@linaro.org>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA52644@DGGEMM506-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi. Zhangfei

Thank you, I will add it in the next patch.

-----????-----
???: zhangfei [mailto:zhangfei.gao at linaro.org] 
????: 2018?1?8? 9:40
???: liwei (CM); robh+dt at kernel.org; mark.rutland at arm.com; xuwei (O); catalin.marinas at arm.com; will.deacon at arm.com; vinholikatti at gmail.com; jejb at linux.vnet.ibm.com; martin.petersen at oracle.com; khilman at baylibre.com; arnd at arndb.de; gregory.clement at free-electrons.com; thomas.petazzoni at free-electrons.com; yamada.masahiro at socionext.com; riku.voipio at linaro.org; treding at nvidia.com; krzk at kernel.org; eric at anholt.net; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-scsi at vger.kernel.org
??: zangleigang; Gengjianfeng; guodong.xu at linaro.org; Fengbaopeng (kevin, Kirin Solution Dept)
??: Re: [PATCH v7 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC

Hi, Wei


On 2018?01?06? 17:51, Li Wei wrote:
> This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.
Usually here should list the change compared with the last change set, to make it easier to reviewer, who may pay more attention to the differences.

For example
v7:xxx //change since v6
v6:xxx // change since v5



> Li Wei (5):
>    scsi: ufs: add Hisilicon ufs driver code
>    dt-bindings: scsi: ufs: add document for hisi-ufs
>    arm64: dts: add ufs dts node
>    arm64: defconfig: enable configs for Hisilicon ufs
>    arm64: defconfig: enable f2fs and squashfs
>
>   Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  43 ++
>   arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  20 +
>   arch/arm64/configs/defconfig                       |  11 +
>   drivers/scsi/ufs/Kconfig                           |   9 +
>   drivers/scsi/ufs/Makefile                          |   1 +
>   drivers/scsi/ufs/ufs-hisi.c                        | 621 +++++++++++++++++++++
>   drivers/scsi/ufs/ufs-hisi.h                        | 116 ++++
>   7 files changed, 821 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>   create mode 100644 drivers/scsi/ufs/ufs-hisi.c
>   create mode 100644 drivers/scsi/ufs/ufs-hisi.h
>
