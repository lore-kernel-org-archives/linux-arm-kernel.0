From: tj@kernel.org (Tejun Heo)
Date: Thu, 10 Jul 2014 10:45:34 -0400
Subject: [PATCH v2 1/2] ata: Fix the watermark threshold for the APM
 X-Gene SATA host controller driver.
In-Reply-To: <1405000156-321-2-git-send-email-stripathi@apm.com>
References: <1405000156-321-1-git-send-email-stripathi@apm.com>
 <1405000156-321-2-git-send-email-stripathi@apm.com>
Message-ID: <20140710144534.GA6609@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 07:19:15PM +0530, Suman Tripathi wrote:
> This patch fixes the watermark threshold of the receive FIFO for the
> APM X-Gene SATA host controller driver.

Can you please explain what are the effects of these patches?  Patch
descriptions should include why the specific changes are being made in
addition to the description of the changes themselves.  What are the
implications of applying this patch?

Thanks.

-- 
tejun
