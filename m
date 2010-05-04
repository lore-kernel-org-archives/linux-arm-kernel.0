From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 4 May 2010 11:14:58 +0100
Subject: [PATCH 1/2] regulator: make max8925 sharing one driver structure
In-Reply-To: <o2o771cded01005040021o74bb8c3cr22c7be427333774b@mail.gmail.com>
References: <o2o771cded01005040021o74bb8c3cr22c7be427333774b@mail.gmail.com>
Message-ID: <20100504101457.GB15454@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 03:21:42AM -0400, Haojian Zhuang wrote:
> From 782297964a48a3b8547a99de3b5c24d8f02b99ec Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 29 Apr 2010 13:33:50 -0400
> Subject: [PATCH] regulator: make max8925 sharing one driver structure
> 
> Remove a lot of driver structures in max8925 driver. Make regulators share
> one driver structure.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
