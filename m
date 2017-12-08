From: liwei213@huawei.com (liwei (CM))
Date: Fri, 8 Dec 2017 01:25:00 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjYgMS81XSBzY3NpOiB1ZnM6IGFkZCBIaXNpbGlj?=
 =?utf-8?Q?on_ufs_driver_code?=
In-Reply-To: <CAOFm3uEgT4gzusQpXb3SnriTdU0nAha2tcVKOoZJRjZw=dx7sg@mail.gmail.com>
References: <20171207102026.14977-1-liwei213@huawei.com>
 <20171207102026.14977-2-liwei213@huawei.com>
 <CAOFm3uEgT4gzusQpXb3SnriTdU0nAha2tcVKOoZJRjZw=dx7sg@mail.gmail.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA4D694@DGGEMM506-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,Philippe,

Thank you for your suggestion, and I'll consider that next patch.

-----????-----
???: Philippe Ombredanne [mailto:pombredanne at nexb.com] 
????: 2017?12?7? 18:34
???: liwei (CM)
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; vinholikatti at gmail.com; James E.J. Bottomley; Martin K. Petersen; khilman at baylibre.com; Arnd Bergmann; gregory.clement at free-electrons.com; Thomas Petazzoni; yamada.masahiro at socionext.com; riku.voipio at linaro.org; treding at nvidia.com; krzk at kernel.org; eric at anholt.net; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS; LKML; moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE; linux-scsi at vger.kernel.org; zangleigang; Gengjianfeng; guodong.xu at linaro.org; zhangfei.gao at linaro.org; Fengbaopeng (kevin, Kirin Solution Dept)
??: Re: [PATCH v6 1/5] scsi: ufs: add Hisilicon ufs driver code

Dear Li,

On Thu, Dec 7, 2017 at 11:20 AM, Li Wei <liwei213@huawei.com> wrote:
> add Hisilicon ufs driver code.
>
> Signed-off-by: Li Wei <liwei213@huawei.com>
> Signed-off-by: Geng Jianfeng <gengjianfeng@hisilicon.com>
> Signed-off-by: Zang Leigang <zangleigang@hisilicon.com>
> Signed-off-by: Yu Jianfeng <steven.yujianfeng@hisilicon.com>
[]

> --- /dev/null
> +++ b/drivers/scsi/ufs/ufs-hisi.c
> @@ -0,0 +1,624 @@
> +/*
> + *
> + * HiSilicon Hixxxx UFS Driver
> + *
> + * Copyright (c) 2016-2017 Linaro Ltd.
> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or 
> +modify
> + * it under the terms of the GNU General Public License as published 
> +by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

Would you consider using the new SPDX license ids instead?
Check Thomas doc patches for instructions.
This would be great and while you are it may be this could be adopted for all HiSilicon and Huawei past, present and future contributions?
Thank you for your kind consideration!

--
Cordially
Philippe Ombredanne
