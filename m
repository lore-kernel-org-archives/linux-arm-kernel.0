From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 22 Feb 2018 15:41:45 +0100
Subject: [PATCH] thermal: exynos: Read soc_type from match data
In-Reply-To: <1519128948-11818-1-git-send-email-m.purski@samsung.com>
References: <CGME20180220121554eucas1p1e97fba2b784a024233d3537c33989f6a@eucas1p1.samsung.com>
 <1519128948-11818-1-git-send-email-m.purski@samsung.com>
Message-ID: <2023948.K0BAVOQXYc@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 20, 2018 01:15:48 PM Maciej Purski wrote:
> Device context's field data->soc is currently obtained by comparing
> of_compatible's. Provide soc_type as .data field in device's match
> table, as it is done in most drivers.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
