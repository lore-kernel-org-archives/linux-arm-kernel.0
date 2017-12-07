From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 7 Dec 2017 11:34:16 +0100
Subject: [PATCH v6 1/5] scsi: ufs: add Hisilicon ufs driver code
In-Reply-To: <20171207102026.14977-2-liwei213@huawei.com>
References: <20171207102026.14977-1-liwei213@huawei.com>
 <20171207102026.14977-2-liwei213@huawei.com>
Message-ID: <CAOFm3uEgT4gzusQpXb3SnriTdU0nAha2tcVKOoZJRjZw=dx7sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

Would you consider using the new SPDX license ids instead?
Check Thomas doc patches for instructions.
This would be great and while you are it may be this could be adopted
for all HiSilicon and Huawei past, present and future contributions?
Thank you for your kind consideration!

-- 
Cordially
Philippe Ombredanne
