From: horms@verge.net.au (Simon Horman)
Date: Tue, 29 Oct 2013 14:55:58 +0900
Subject: [PATCH 03/12] clocksource: sh_tmu: Add clk_prepare/unprepare
 support
In-Reply-To: <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131029055558.GD11580@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 11:49:20PM +0100, Laurent Pinchart wrote:
> Prepare the clock at probe time, as there is no other appropriate place
> in the driver where we're allowed to sleep.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/clocksource/sh_tmu.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

Thanks Laurent,

I have queued this up in the clocksources branch of my renesas tree.
I will send a pull request to Mike once v3.13-rc1 has hit the shelves.
Mike, please let me know if you would prefer something earlier than that.
