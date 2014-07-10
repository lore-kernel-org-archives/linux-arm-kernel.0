From: tj@kernel.org (Tejun Heo)
Date: Thu, 10 Jul 2014 10:46:24 -0400
Subject: [PATCH v2 2/2] arm64: Fix the APM X-Gene SoC SATA PHY clock DTS
 node csr-mask of the SATA Host Controller 1.
In-Reply-To: <1405000156-321-3-git-send-email-stripathi@apm.com>
References: <1405000156-321-1-git-send-email-stripathi@apm.com>
 <1405000156-321-3-git-send-email-stripathi@apm.com>
Message-ID: <20140710144624.GB6609@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 07:19:16PM +0530, Suman Tripathi wrote:
> This patch fixes the SATA PHY clock DTS node csr-mask of the
> SATA Host controller 1. This patch also fixes the status of
> the PHY clock node of SATA Host Controller 1.

Ditto.  Before, XXX was wrong and as a result YYY didn't work
properly.  This patch updates ZZZ to fix the issue.

-- 
tejun
