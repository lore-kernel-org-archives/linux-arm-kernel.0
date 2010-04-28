From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Apr 2010 14:01:03 +0100
Subject: [PATCH 01/01] regulator: fix enabling regulator issue on max8925
In-Reply-To: <k2u771cded01004280559s156ff50bnb172767893c89845@mail.gmail.com>
References: <k2u771cded01004280559s156ff50bnb172767893c89845@mail.gmail.com>
Message-ID: <20100428130103.GG31400@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 08:59:22AM -0400, Haojian Zhuang wrote:
> From 9f421a29db78635210b29df1d5f83bdc523e3178 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 6 Apr 2010 06:19:15 -0400
> Subject: [PATCH] regulator: fix enabling regulator issue on max8925
> 
> Fix regulator enabling issue that is caused by typo error in is_enabled().
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
