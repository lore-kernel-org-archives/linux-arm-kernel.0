From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Mar 2011 21:07:27 +0100
Subject: [trivial PATCH 2/2] arm: mach-u300/gpio: Fix mem_region resource
	size miscalculations
In-Reply-To: <798d0aea7272beadf2ee838f7aa27f86cfe7f9ba.1300909446.git.joe@perches.com>
References: <cover.1300909445.git.joe@perches.com>
	<798d0aea7272beadf2ee838f7aa27f86cfe7f9ba.1300909446.git.joe@perches.com>
Message-ID: <AANLkTika-y8bqaXFp008C28wd_YzmcBm2mj5ZLfxSSSy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/23 Joe Perches <joe@perches.com>:

> Convert off-by-1 r->end - r->start to resource_size(r)
>
> Signed-off-by: Joe Perches <joe@perches.com>

Oh man, there was one of these lurking in my own beloved mach-u300.
How embarrassing. Thanks for catching!

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
