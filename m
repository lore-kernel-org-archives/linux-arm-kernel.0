From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Nov 2013 10:42:14 +0900
Subject: [PATCH 7/7] ARM: shmobile: armadillo-reference: Use low level
 IRQ for ST1231
In-Reply-To: <1383999839-3339-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383999839-3339-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131119014214.GF17628@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 09, 2013 at 01:23:59PM +0100, Laurent Pinchart wrote:
> The device is configured to generate an active-low interrupt signal that
> needs to be acknowledged by the host. Configure the IRQ to trigger on
> low level.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.
