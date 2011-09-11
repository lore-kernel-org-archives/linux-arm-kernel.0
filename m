From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 11 Sep 2011 16:29:38 +0300
Subject: [PATCH v4] mach-realview: expose PB1176 ROM using physmap and
	map_rom
In-Reply-To: <1315292023-4125-1-git-send-email-linus.walleij@stericsson.com>
References: <1315292023-4125-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1315747783.18731.59.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-09-06 at 08:53 +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This exposes the PB1176 ROM if you compile in the MTD physmap
> mapping and also the map_rom chiptype.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

I think this should go in via the corresponding arm subtree.

-- 
Best Regards,
Artem Bityutskiy
