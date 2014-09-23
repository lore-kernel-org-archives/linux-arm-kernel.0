From: tj@kernel.org (Tejun Heo)
Date: Tue, 23 Sep 2014 10:22:21 -0400
Subject: [PATCH] ahci_xgene: Fix the error print invalid resource for APM
 X-Gene SoC AHCI SATA Host Controller driver.
In-Reply-To: <1411390893-22911-2-git-send-email-stripathi@apm.com>
References: <1411390893-22911-1-git-send-email-stripathi@apm.com>
 <1411390893-22911-2-git-send-email-stripathi@apm.com>
Message-ID: <20140923142221.GA19208@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 06:31:33PM +0530, Suman Tripathi wrote:
> This patch fixes the error print invalid resource for the APM X-Gene
> SoC AHCI SATA Host Controller driver. This print was due to the fact
> that the controller 3 don't have a mux resource. This didn't result
> in any errors but the print seems like meaningless.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Applied to libata/for-3.18.

Thanks.

-- 
tejun
