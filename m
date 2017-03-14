From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Mar 2017 16:15:42 +0800
Subject: [PATCH] arm64: dts: updated sata node on ls1012a platform
In-Reply-To: <1489458574-5556-1-git-send-email-andy.tang@nxp.com>
References: <1489458574-5556-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170314081536.GO3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 10:29:34AM +0800, Yuantian Tang wrote:
> Updated sata node to add ecc register address and dma coherence
> property.
> Enable sata on ls1012a platforms as well.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>

Applied, thanks.

A side note: we usually use present rather than past tense in patch
subject.

Shawn
