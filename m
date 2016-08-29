From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 09:23:12 +0800
Subject: [PATCH] ARM: dts: imx6q-bx50v3: configure unused pca953x pins
In-Reply-To: <1471023911-2763-1-git-send-email-akshay.bhat@timesys.com>
References: <1471023911-2763-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <20160829012312.GB30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 01:45:11PM -0400, Akshay Bhat wrote:
> From: Ken Lin <ken.lin@advantech.com.tw>
> 
> At power on, pca953x GPIO pins are configured as input and may cause
> unexpected interrupts. Configure the unused pins as GPO low to
> avoid unexpected interrupts.
> 
> Signed-off-by: Ken Lin <ken.lin@advantech.com.tw>
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>

Applied, thanks.
