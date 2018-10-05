From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 5 Oct 2018 21:04:22 +0800
Subject: [PATCH 09/12] i2c: zx2967: use core to detect 'no zero length'
 quirk
In-Reply-To: <20180723202617.15230-10-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-10-wsa+renesas@sang-engineering.com>
Message-ID: <20181005130420.GA3587@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 10:26:13PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
