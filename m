From: horms@verge.net.au (Simon Horman)
Date: Thu, 31 Oct 2013 14:23:57 +0900
Subject: [PATCH v2 1/2] clocksource: sh_tmu: Release clock when
 sh_tmu_register() fails
In-Reply-To: <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131031052357.GM1603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 03:31:36PM +0100, Laurent Pinchart wrote:
> Fix the probe error path to release the clock resource when the
> sh_tmu_register() call fails.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.
