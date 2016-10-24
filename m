From: weiyongjun1@huawei.com (weiyongjun (A))
Date: Mon, 24 Oct 2016 00:24:41 +0000
Subject: [PATCH -next] ARM: mediatek: add terminate entry for
 of_device_id tables
In-Reply-To: <1477222977-1336-1-git-send-email-weiyj.lk@gmail.com>
References: <1477222977-1336-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <6AADFAC011213A4C87B956458587ADB46DF125@SZXEMI508-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Wei Yongjun [mailto:weiyj.lk at gmail.com]
> Sent: Sunday, October 23, 2016 7:43 PM
> To: Matthias Brugger <matthias.bgg@gmail.com>; Russell King
> <linux@armlinux.org.uk>
> Cc: weiyongjun (A) <weiyongjun1@huawei.com>; linux-arm-
> kernel at lists.infradead.org; linux-mediatek at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: [PATCH -next] ARM: mediatek: add terminate entry for
> of_device_id tables
> 
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Make sure of_device_id tables are NULL terminated.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  arch/arm/mach-mediatek/platsmp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Sorry, this patch is not correct since mtk_tz_smp_boot_infos is used
as ARRAY_SIZE(mtk_tz_smp_boot_infos), please ignore it.

Regards,
Yongjun Wei
