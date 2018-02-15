From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 15 Feb 2018 18:51:01 -0500
Subject: [PATCH v8 0/5] scsi: ufs: add ufs driver code for Hisilicon
 Hi3660 SoC
In-Reply-To: <20180213101412.5717-1-liwei213@huawei.com> (Li Wei's message of
 "Tue, 13 Feb 2018 18:14:07 +0800")
References: <20180213101412.5717-1-liwei213@huawei.com>
Message-ID: <yq13721lsm2.fsf@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


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

Is the intent for this series to go through the SCSI tree? If so, I'll
need some acks from the ARM maintainers for the dt/platform changes.

-- 
Martin K. Petersen	Oracle Linux Engineering
