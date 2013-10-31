From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 15:38:22 +0800
Subject: [PATCH] ARM: i.MX6q: fix the wrong parent of can_root clock
In-Reply-To: <1383132351-32112-1-git-send-email-jiada_wang@mentor.com>
References: <1383132351-32112-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <20131031073820.GH23549@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 04:25:51AM -0700, jiada_wang at mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> instead of pll3_usb_otg the parent of can_root clock
> should be pll3_60m.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Applied, thanks.
