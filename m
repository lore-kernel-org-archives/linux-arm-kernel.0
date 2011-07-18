From: avictor.za@gmail.com (Andrew Victor)
Date: Mon, 18 Jul 2011 09:35:28 +0200
Subject: [PATCH 4/7] at91: remove non used at91_spi.h
In-Reply-To: <20110717023602.GF20678@game.jcrosoft.org>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-4-git-send-email-plagnioj@jcrosoft.com>
	<4E2028E1.1060603@vollmann.ch>
	<20110715154636.GA20678@game.jcrosoft.org>
	<4E206E7D.2070708@vollmann.ch>
	<20110716105752.GD20678@game.jcrosoft.org>
	<4E21950B.4040109@vollmann.ch>
	<20110717023602.GF20678@game.jcrosoft.org>
Message-ID: <CAFumwP0W6uy8kNyZ-cCfGTvKaKKoP+G9z3pW07H-p1tLQpb_YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> if you need to atmel_spi.h for mainline for other drivers you need to post
> your patch.

The at91_spi.h header is also use by the original SPI stack.  The
atmel_spi and mtd_dataflash don't work properly for AT91RM9200-based
boards, therefore out-of-tree drivers need to be used.
http://maxim.org.za/at91_26.html
(And I have spent way too many hours trying to get atmel_spi to work)

Regards,
  Andrew Victor
