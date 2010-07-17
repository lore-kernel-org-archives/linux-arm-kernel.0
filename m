From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 17 Jul 2010 12:00:38 +0200
Subject: [PATCH 02/15] arm/mach-u300: check kmalloc result
In-Reply-To: <1279296767-24823-1-git-send-email-segooon@gmail.com>
References: <1279296767-24823-1-git-send-email-segooon@gmail.com>
Message-ID: <AANLkTinb-TcOBX69tjR1Z3OdYmNvDwHMl_-C-39eWyCu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/16 Kulikov Vasiliy <segooon@gmail.com>:

> ?arch/arm/mach-u300/dummyspichip.c | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)

NACK I have recently submitted two patches to move this test chip to
drivers/spi, please base your fixes work on top of those patches
instead, and make sure to mail them to Grant Likely and the
spi-devel-general list.

Yours,
Linus Walleij
