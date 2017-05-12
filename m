From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 12 May 2017 11:28:19 +0800
Subject: [PATCH v2] arm64: dts: ls1088a: update the sata node
In-Reply-To: <1494489680-9544-1-git-send-email-andy.tang@nxp.com>
References: <1494489680-9544-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170512032817.GE8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 04:01:19PM +0800, Yuantian Tang wrote:
> 1. Sata ecc should be disabled due to a erratum.
> Provide the ecc register address for driver to use.
> 2. Enable dma coherence operation
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>

Applied, thanks.
