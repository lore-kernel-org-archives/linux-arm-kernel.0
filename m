From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 09:26:03 +0800
Subject: [PATCH v2] ARM: dts: imx6q-ba16: Remove unused vqmmc-supply
In-Reply-To: <1460476884-20612-1-git-send-email-akshay.bhat@timesys.com>
References: <1460476884-20612-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <20160413012603.GA28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 12:01:24PM -0400, Akshay Bhat wrote:
> The vqmmc supply is not connected to bio supply on the BA16 module.
> Hence remove vqmmc-supply property in usdhc3 node.
> 
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>

Applied, thanks.
