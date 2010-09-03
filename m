From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 3 Sep 2010 21:38:45 +0200
Subject: [PATCH] MMC: move regulator handling closer to core v2
In-Reply-To: <1283268367-3525-1-git-send-email-linus.walleij@stericsson.com>
References: <1283268367-3525-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/31 Linus Walleij <linus.walleij@stericsson.com>:

> After discovering a problem in regulator reference counting I
> took Mark Brown's advice to move the reference count into the
> MMC core by making the regulator status a member of
> struct mmc_host.

This has an Reveiwed-by from the regulator maintainer and
seems to address all comments, noone is objection so Andrew
can you pick it up?

Yours,
Linus Walleij
