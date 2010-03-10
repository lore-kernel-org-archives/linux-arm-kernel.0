From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 10 Mar 2010 14:25:54 +0000
Subject: [PATCH 1/4] pxa: move ssp into plat
In-Reply-To: <771cded01003100513k79133820j12c31f369309b0ae@mail.gmail.com>
References: <771cded01003100513k79133820j12c31f369309b0ae@mail.gmail.com>
Message-ID: <20100310142554.GA24422@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 08:13:56AM -0500, Haojian Zhuang wrote:
> From de71c00acab6e4ec61c3e151a54de4c2045a8e74 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 10 Mar 2010 06:26:09 -0500
> Subject: [PATCH] [ARM] pxa: move ssp into plat
> 
> Since ssp is shared between pxa and mmp, move ssp driver into plat directory.
> ---

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but you forgot your Signed-off-by.
