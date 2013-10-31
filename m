From: horms@verge.net.au (Simon Horman)
Date: Thu, 31 Oct 2013 14:23:24 +0900
Subject: [PATCH v2 2/2] clocksource: sh_mtu2: Add clk_prepare/unprepare
 support
In-Reply-To: <1383057045-22608-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057045-22608-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057045-22608-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131031052324.GL1603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 03:30:45PM +0100, Laurent Pinchart wrote:
> Prepare the clock at probe time, as there is no other appropriate place
> in the driver where we're allowed to sleep.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.
