From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 02 Dec 2010 05:31:24 +0200
Subject: [PATCH 1/3] mtd: FSMC NAND remove PARTITION macro and fix
	compile noise
In-Reply-To: <1291035126-17770-1-git-send-email-linus.walleij@stericsson.com>
References: <1291035126-17770-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1291260684.14534.3.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-29 at 13:52 +0100, Linus Walleij wrote:
> This removes the PARTITION macro that David didn't like and also
> removes a local variable that was dangling unused in some #ifdefs
> by being a bit more clever.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Pushed this to l2-mtd-2.6.git, thanks.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
