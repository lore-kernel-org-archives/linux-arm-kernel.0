From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Aug 2012 20:02:24 -0400
Subject: arm: move plat-orion platform_data headers to the right place
In-Reply-To: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120829000224.GN19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 08:59:01PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> plat-orion/include/plat contains a bunch of headers with platform_data
> structure definitions. Those headers should now be in
> <linux/platform_data/...>, so this patch series is moving them
> here. This impacts the MTD, USB EHCI, sound, MMC, DMA XOR drivers.
> 
> Moreover, this series takes this opportunity to move two other
> platform_data headers that were in <linux/...>. This impacts the I2C
> and Ethernet drivers.
> 
> This series has been built tested for orion5x_defconfig,
> dove_defconfig, kirkwood_defconfig and mv78x00_defconfig.
> 
> Thanks,
> 
> Thomas

Entire series applied to:

git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7-v2

thx,

Jason.
