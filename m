From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 7 Jul 2010 22:34:17 +0200
Subject: [PATCH 01/12] mmci: use sg_miter API to fix multi-page sg
	handling
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <AANLkTikv1jFoRfTIVb_DtAjB-K5QqmacIA5FPB4am4SW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've tested this MMCI patch set on RealView PB1176 and
U300, mounted cards, copied files back and forth, unmount
diff files. No problems.

This should cover all MMCI variants, since the PB1176 is a
vanilla ARM variant.

Just fix the comments on patch #7 and it should be ripe for
the patch tracker methinks.

Yours,
Linus Walleij
