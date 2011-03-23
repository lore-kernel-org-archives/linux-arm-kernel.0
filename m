From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Mar 2011 21:11:15 +0100
Subject: [trivial PATCH 1/2] treewide: Fix iomap resource size
	miscalculations
In-Reply-To: <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
References: <cover.1300909445.git.joe@perches.com>
	<c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
Message-ID: <AANLkTikOJ4ed+ExLs1Okm2iFrE95SmR1809bT43bzm8X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/23 Joe Perches <joe@perches.com>:

> Convert off-by-1 r->end - r->start to resource_size(r)
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
(for ux500)

Yours,
Linus Walleij
