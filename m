From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 18 Aug 2010 21:24:56 +0200
Subject: scatter gather
In-Reply-To: <20100818122109.7596.qmail@web4209.mail.ogk.yahoo.co.jp>
References: <20100818122109.7596.qmail@web4209.mail.ogk.yahoo.co.jp>
Message-ID: <AANLkTi=vuEKpZR9XKs1QB6-JipWHo48Z=8Gz8ROhLt+m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/18 Round Robinjp <roundrobinjp@yahoo.co.jp>:

> Is scatter gather supported on ARM linux?

What do you mean by this? There is plenty of generic kernel
code using <linux/scatterlist.h>, and the implementation
is in lib/scatterlist.c, it's available on all archs AFAICT.

Yours,
Linus Walleij
