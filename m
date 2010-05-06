From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Thu, 06 May 2010 10:13:18 +0100
Subject: [PATCH v2 1/2] regulator: make 88pm860x sharing one driver
	structure
In-Reply-To: <k2h771cded01005042234v438edb71h5456bf19fdb474b9@mail.gmail.com>
References: <k2h771cded01005042234v438edb71h5456bf19fdb474b9@mail.gmail.com>
Message-ID: <1273137198.2992.22.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-05 at 01:34 -0400, Haojian Zhuang wrote:
> From 782297964a48a3b8547a99de3b5c24d8f02b99ec Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 29 Apr 2010 13:33:50 -0400
> Subject: [PATCH] regulator: make 88pm860x sharing one driver structure
> 
> Remove a lot of driver structures in 88pm860x driver. Make regulators share
> one driver structure.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Both applied with fixes for your mailer mangling the patches.

Thanks.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
