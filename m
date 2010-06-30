From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 1 Jul 2010 00:03:29 +0200
Subject: [PATCH 33/33] Removing dead MACH_U300_USE_I2S_AS_MASTER
In-Reply-To: <41be9a8afe8951b4ad23d43fcb57aca9a662cf43.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<41be9a8afe8951b4ad23d43fcb57aca9a662cf43.1277911346.git.siccegge@cs.fau.de>
Message-ID: <AANLkTinHA5PsD_5i-YgRNSNzddsqc1JojDN5AvC9ot8C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/30 Christoph Egger <siccegge@cs.fau.de>:

> MACH_U300_USE_I2S_AS_MASTER doesn't exist in Kconfig, therefore
> removing all references for it from the source code.
>
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

I remember the pain of writing that code, but until I get around to merge that
ancient driver I see no point in keeping it around, so:
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
