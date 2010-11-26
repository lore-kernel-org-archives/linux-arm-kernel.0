From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 26 Nov 2010 18:24:55 +0200
Subject: [PATCH 2/4] mtd: FSMC NAND replace all use of uintNN_t with uN
In-Reply-To: <1290201121-15263-1-git-send-email-linus.walleij@stericsson.com>
References: <1290201121-15263-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1290788695.2552.35.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-19 at 22:12 +0100, Linus Walleij wrote:
> The short kernel versions of the basic types makes the world more
> readable.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

I do not think dwmw2 will merge this one because he often claimed that
u32 cannot be better than uint32_t, because the latter is C99 standard,
but the former is not. So I'd not do this, at least not at the area he
looks after.

:-)

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
