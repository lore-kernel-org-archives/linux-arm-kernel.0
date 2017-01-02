From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 2 Jan 2017 17:17:06 +0800
Subject: [PATCH] arm64/dts/ls2080a-rdb: remove disable status of pca9547
In-Reply-To: <1482213787-27814-1-git-send-email-meng.yi@nxp.com>
References: <1482213787-27814-1-git-send-email-meng.yi@nxp.com>
Message-ID: <20170102091705.GI20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 02:03:07PM +0800, Meng Yi wrote:
> pca9547 won't probed since its status property is disabled.
> while there are devices connected to it, we need remove status
> property to let ds3232 and adt7461 probed correctly.
> 
> Signed-off-by: Meng Yi <meng.yi@nxp.com>

Changed subject prefix to 'arm64: dts: ls2080a-rdb: ', and applied the
patch.

Shawn
