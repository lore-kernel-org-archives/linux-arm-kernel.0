From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 26 Jun 2017 08:28:07 +0530
Subject: [PATCH] dmaengine: qcom_hidma: allow ACPI/DT parameters to be
 overridden
In-Reply-To: <1498157962-27962-1-git-send-email-okaya@codeaurora.org>
References: <1498157962-27962-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20170626025805.GW19154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 02:59:22PM -0400, Sinan Kaya wrote:
> Parameters like maximum read/write request size and the maximum
> number of active transactions are currently configured in DT/ACPI.
> 
> This patch allows a user to override these to fine tune performance
> for their application.

Applied, thanks

-- 
~Vinod
