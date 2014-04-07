From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 7 Apr 2014 08:56:52 +0200
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <5342481B.6020600@monstr.eu>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de>
 <5342481B.6020600@monstr.eu>
Message-ID: <20140407065651.GA2609@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I would suggest to add relaxed IO helper function to asm-generic/io.h
> to be available for all archs. Then we can avoid this type of errors.

I favour this, too. For the cadence driver, I needed a quick solution
before linux-next breaks, though.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/b36acb98/attachment.sig>
