From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 22 Mar 2013 23:24:00 +0100
Subject: [PATCH v2 1/2] i2c: s3c2410: move mach/regs-iic.h into
 i2c-s3c2410 device driver
In-Reply-To: <201303211509.25607.heiko@sntech.de>
References: <201303211509.25607.heiko@sntech.de>
Message-ID: <20130322222400.GA6428@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:09:25PM +0100, Heiko St?bner wrote:
> The register definitions are only used in the driver itself.
> This also removes the last dependency on plat/ includes from the
> i2c driver.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Both applied to for-next, thanks!
