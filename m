From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 5 May 2010 12:18:34 +0100
Subject: [PATCH v2 2/2] regulator: use voltage number array in 88pm860x
In-Reply-To: <h2n771cded01005042235o9acec456j2ebdb906861742ae@mail.gmail.com>
References: <h2n771cded01005042235o9acec456j2ebdb906861742ae@mail.gmail.com>
Message-ID: <20100505111834.GC5754@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 05, 2010 at 01:35:59AM -0400, Haojian Zhuang wrote:
> From 5dbf0d4d5ad601b508730a8d0f5a41a1edb92561 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 4 May 2010 09:54:51 -0400
> Subject: [PATCH] regulator: use voltage number array in 88pm860x
> 
> A lot of condition comparision statements are used in original driver. These
> statements are used to check the boundary of voltage numbers since voltage
> number isn't linear.
> 
> Now use array of voltage numbers instead. Clean code with simpler way.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Again I'm not clear on the changes but this does actually still look OK
for me.
