From: tj@kernel.org (Tejun Heo)
Date: Tue, 23 Sep 2014 09:17:30 -0400
Subject: [PATCH v5 1/2] ahci-platform: Bump max number of clocks to 5
In-Reply-To: <1411416586-18320-1-git-send-email-galak@codeaurora.org>
References: <1411416586-18320-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140923131730.GD14905@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 03:09:45PM -0500, Kumar Gala wrote:
> Qualcomm IPQ806x SoCs with SATA controllers need 5 clocks to be enabled.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Applied 1-2 to libata/for-3.18.

Thanks.

-- 
tejun
