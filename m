From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 20:59:03 +0800
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: cleanup eMMC node
In-Reply-To: <20180516065349.11160-1-nikita.yoush@cogentembedded.com>
References: <20180516065349.11160-1-nikita.yoush@cogentembedded.com>
Message-ID: <20180520125902.GZ26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 09:53:49AM +0300, Nikita Yushchenko wrote:
> On RDU1, sdhc1 is used for eMMC, and that is 3.3V only.
> 
> Thus configure device node not to probe it as SD/SDIO and not try 1.8V.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Applied, thanks.
