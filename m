From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 20 May 2010 09:53:02 -0700
Subject: [PATCH 01/05] input: fix irq number of onkey in 88pm860x
In-Reply-To: <AANLkTinXrmCnCU3SbM2GK7-wChZxv-t_jel_Jo_M5Gq-@mail.gmail.com>
References: <AANLkTinXrmCnCU3SbM2GK7-wChZxv-t_jel_Jo_M5Gq-@mail.gmail.com>
Message-ID: <20100520165301.GB20861@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 02:56:36PM +0800, Haojian Zhuang wrote:
> From ba4446e036f9bf088f4b89ef04ae197bc37ed0e5 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 19 May 2010 09:50:56 +0800
> Subject: [PATCH] input: fix irq number of onkey in 88pm860x
> 
> Irq number of onkey is assigned twice. The second assignment is wrong.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Applied, thanks Haojian.

-- 
Dmitry
