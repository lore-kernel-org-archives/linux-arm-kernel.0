From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Apr 2014 14:24:59 +0800
Subject: [PATCH] ARM; i.MX: Fix eMMa PrP resource size
In-Reply-To: <1398614606-30179-1-git-send-email-shc_work@mail.ru>
References: <1398614606-30179-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140429062457.GK16451@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 08:03:26PM +0400, Alexander Shiyan wrote:
> Last address for eMMa PrP is 0x80...0x83, so increase resource size
> for eMMa to 256.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.
