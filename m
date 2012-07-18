From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 18 Jul 2012 19:17:32 +0530
Subject: Devicetree: Initialization order of mmc block devices?
In-Reply-To: <50068696.8070408@de.bosch.com>
References: <5006571A.7060103@de.bosch.com>
 <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
 <50068696.8070408@de.bosch.com>
Message-ID: <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2012 15:19, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:

> If a SD card is inserted at boot time, its "mmcblk0", the embedded
> MMC (eMMC) device "mmcblk1".  This makes it difficult to give the kernel the
> correct device for the eMMC root file system ("root=/dev/mmcblk?p1 ...").
>
How about  root=UUID=<eMMC-partition>  ?
