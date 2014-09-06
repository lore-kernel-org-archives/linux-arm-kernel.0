From: tj@kernel.org (Tejun Heo)
Date: Sat, 6 Sep 2014 11:27:46 +0900
Subject: [PATCH v9 2/3] ahci_xgene: Skip the PHY and clock initialization
 if already configured by the firmware.
In-Reply-To: <1409217682-5759-3-git-send-email-stripathi@apm.com>
References: <1409217682-5759-1-git-send-email-stripathi@apm.com>
 <1409217682-5759-3-git-send-email-stripathi@apm.com>
Message-ID: <20140906022746.GA21579@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 02:51:21PM +0530, Suman Tripathi wrote:
> This patch implements the feature to skip the PHY and clock
> initialization if it is already configured by the firmware.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Applied to libata/for-3.17-fixes.

Thanks.

-- 
tejun
