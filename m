From: liwei213@huawei.com (liwei (CM))
Date: Fri, 23 Feb 2018 07:47:07 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHY4IDAvNV0gc2NzaTogdWZzOiBhZGQgdWZzIGRyaXZl?=
 =?gb2312?Q?r_code_for_Hisilicon_Hi3660_SoC?=
In-Reply-To: <yq13721lsm2.fsf@oracle.com>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <yq13721lsm2.fsf@oracle.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA56220@DGGEMM506-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Martin K

Sorry late for you. 
Yes?our intent for this series is to go through the SCSI tree.

-----????-----
???: Martin K. Petersen [mailto:martin.petersen at oracle.com] 
????: 2018?2?16? 7:51
???: liwei (CM)
??: robh+dt at kernel.org; mark.rutland at arm.com; xuwei (O); catalin.marinas at arm.com; will.deacon at arm.com; vinholikatti at gmail.com; jejb at linux.vnet.ibm.com; martin.petersen at oracle.com; khilman at baylibre.com; arnd at arndb.de; gregory.clement at free-electrons.com; thomas.petazzoni at free-electrons.com; yamada.masahiro at socionext.com; riku.voipio at linaro.org; treding at nvidia.com; krzk at kernel.org; eric at anholt.net; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-scsi at vger.kernel.org; zangleigang; Gengjianfeng; guodong.xu at linaro.org; zhangfei.gao at linaro.org; Fengbaopeng (kevin, Kirin Solution Dept)
??: Re: [PATCH v8 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC


Li,

> This patchset adds driver support for UFS for Hi3660 SoC. It is 
> verified on HiKey960 board.
>
> Li Wei (5):
>   scsi: ufs: add Hisilicon ufs driver code
>   dt-bindings: scsi: ufs: add document for hisi-ufs
>   arm64: dts: add ufs dts node
>   arm64: defconfig: enable configs for Hisilicon ufs
>   arm64: defconfig: enable f2fs and squashfs

Is the intent for this series to go through the SCSI tree? If so, I'll need some acks from the ARM maintainers for the dt/platform changes.

-- 
Martin K. Petersen	Oracle Linux Engineering
