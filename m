From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 13 Mar 2014 18:01:52 +0100
Subject: [PATCH v17 3/4] ata: Add APM X-Gene SoC AHCI SATA host controller
 driver
In-Reply-To: <1394655573-32645-4-git-send-email-lho@apm.com>
References: <1394655573-32645-1-git-send-email-lho@apm.com>
 <1394655573-32645-3-git-send-email-lho@apm.com>
 <1394655573-32645-4-git-send-email-lho@apm.com>
Message-ID: <2321534.cVUPvrOVDn@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 12, 2014 02:19:32 PM Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC AHCI SATA host controller
> driver. It requires the corresponding APM X-Gene SoC PHY driver. This
> initial version only supports Gen3 speed.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks for fixing all the remaining issues.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
