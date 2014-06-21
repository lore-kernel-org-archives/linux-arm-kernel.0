From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Jun 2014 12:40:27 +0800
Subject: [PATCH 1/2] ARM: dts: mx5: Fix IPU port node placement
In-Reply-To: <1402618960-9735-1-git-send-email-marex@denx.de>
References: <1402618960-9735-1-git-send-email-marex@denx.de>
Message-ID: <20140621044025.GA6818@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 02:22:39AM +0200, Marek Vasut wrote:
> The "port" node was misplaced in the original patch, therefore making
> the LCD dysfunctional on this board. Fix this by moving the "port" DT
> node into the "display {}" node.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied both, thanks.
