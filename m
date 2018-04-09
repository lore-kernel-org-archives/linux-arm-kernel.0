From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 09 Apr 2018 11:49:41 +0200
Subject: [PATCH 07/16] media: exymos4-is: allow compile test for EXYNOS
 FIMC-LITE
In-Reply-To: <3cf43e723f17b55d99d817efa535ded43561b1f6.1522949748.git.mchehab@s-opensource.com>
References: <cover.1522949748.git.mchehab@s-opensource.com>
 <3cf43e723f17b55d99d817efa535ded43561b1f6.1522949748.git.mchehab@s-opensource.com>
 <CGME20180409094946epcas1p1db108f4fcd018081c90787478004d907@epcas1p1.samsung.com>
Message-ID: <132c72ed-1211-682a-1926-79b10eae42c1@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2018 07:54 PM, Mauro Carvalho Chehab wrote:
> There's nothing that prevents building this driver with
> COMPILE_TEST. So, enable it.
> 
> While here, make the Kconfig dependency cleaner by removing
> the unneeded if block.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

With s/exymos4-is/exynos4-is in the subject

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
