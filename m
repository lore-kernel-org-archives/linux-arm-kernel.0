From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 11 Apr 2017 18:32:04 +0800
Subject: [PATCH] ARM: mxs: add support for I2SE Duckbill 2 boards
In-Reply-To: <1491815335-26469-1-git-send-email-michael.heimpold@i2se.com>
References: <20170410082400.GA1872@dragon>
 <1491815335-26469-1-git-send-email-michael.heimpold@i2se.com>
Message-ID: <20170411103202.GA9880@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 11:08:55AM +0200, Michael Heimpold wrote:
> The Duckbill devices are small, pen-drive sized boards based on
> NXP's i.MX28 SoC. While the initial variants (Duckbill series)
> were equipped with a micro SD card slot only, the latest generation
> (Duckbill 2 series) have an additional internal eMMC onboard.
> 
> To distinguish between both generations, a new device tree
> compatible string was introduced. To get the MAC address fixup
> applied, we need to check for this new string here, too.
> 
> Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>

Applied, thanks.
