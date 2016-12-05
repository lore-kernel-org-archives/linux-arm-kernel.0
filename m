From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Dec 2016 10:48:04 +0800
Subject: [PATCH v2] arm64: dts: zx: support cpu-freq for zx296718
In-Reply-To: <1480657956-8140-1-git-send-email-baoyou.xie@linaro.org>
References: <1480657956-8140-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20161205024803.GA2667@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 01:52:36PM +0800, Baoyou Xie wrote:
> This patch adds the CPU clock phandle in CPU's node
> and uses operating-points-v2 to register operating points.
> 
> So it can be used by cpufreq-dt driver.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Applied, thanks.
