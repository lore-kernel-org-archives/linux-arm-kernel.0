From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 Jun 2014 22:37:03 +0800
Subject: [PATCH 1/2] ARM: imx: mem bit must be cleared before entering
 DSM mode
In-Reply-To: <1403512964-19095-1-git-send-email-b20788@freescale.com>
References: <1403512964-19095-1-git-send-email-b20788@freescale.com>
Message-ID: <20140625143702.GG2224@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 04:42:43PM +0800, Anson Huang wrote:
> According to hardware design, mem bit must be clear before
> entering DSM mode, as ARM core will be power gated in DSM mode.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied both, thanks.
