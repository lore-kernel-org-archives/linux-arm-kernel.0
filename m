From: tj@kernel.org (Tejun Heo)
Date: Tue, 29 Oct 2013 14:41:20 -0400
Subject: [PATCH 04/12] sata_rcar: Convert to clk_prepare/unprepare
In-Reply-To: <1383000569-8916-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131029184120.GA21990@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 11:49:21PM +0100, Laurent Pinchart wrote:
> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> clk_disable_unprepare() to get ready for the migration to the common
> clock framework.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied to libata/for-3.13.

Thanks.

-- 
tejun
