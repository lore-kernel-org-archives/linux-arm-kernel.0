From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 May 2011 15:15:35 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <BANLkTin7_4ijP92u4Zd55zWaMEbv=zbOgA@mail.gmail.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
	<BANLkTin7_4ijP92u4Zd55zWaMEbv=zbOgA@mail.gmail.com>
Message-ID: <BANLkTik1UzRnCFep1PK75MKmf7zDdDxbEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/12 Per Forlin <per.forlin@linaro.org>:

> I am willingly to test this dma race condition if there are
> any doubts whether it still exists or not.

That'd be super, can you test on U8500 and U5500 alike and report
results, but if it's gone I'd very much like to know why, since in
theory the problem is still there (provided I'm not completely
misunderstanding the hardware, which is quite possible).

Thanks,
Linus Walleij
