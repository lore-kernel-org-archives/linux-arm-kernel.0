From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 15:04:22 +0800
Subject: [PATCH v2 1/1] ARM: imx: clk-pllv3: improve the timeout waiting
 method
In-Reply-To: <1373941400-32274-1-git-send-email-peter.chen@freescale.com>
References: <1373941400-32274-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130716070419.GC30067@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 10:23:20AM +0800, Peter Chen wrote:
> There are two improvements for this commit:
> 
> - Add comparing pll lock condition after while loop. It can
> fix potential fake timeout problem caused by the code is just
> scheduled out before compare the timeout, and the time of
> scheduling out are more than one jiffies.
> 
> - Move timeout assignment more close to compare the timeout.
> It can reduce the possibility the code is scheduled out, and
> the timeout can be more precise.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Applied, thanks.
