From: tj@kernel.org (Tejun Heo)
Date: Sat, 16 Aug 2014 09:09:45 -0400
Subject: [PATCH v6 1/2] ahci_xgene: Removing NCQ support from the APM
 X-Gene SoC AHCI SATA Host Controller driver.
In-Reply-To: <1407514466-25312-2-git-send-email-stripathi@apm.com>
References: <1407514466-25312-1-git-send-email-stripathi@apm.com>
 <1407514466-25312-2-git-send-email-stripathi@apm.com>
Message-ID: <20140816130945.GI9305@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 09:44:25PM +0530, Suman Tripathi wrote:
> This patch removes the NCQ support from the APM X-Gene SoC AHCI
> Host Controller driver as it doesn't support it.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Applied to libata/for-3.17-fixes w/ stable cc'd.

Thanks.

-- 
tejun
