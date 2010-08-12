From: vapier.adi@gmail.com (Mike Frysinger)
Date: Wed, 11 Aug 2010 23:36:31 -0400
Subject: [PATCH 1/2 v2] ARM: Fix gen_nand probe structures contents
In-Reply-To: <1281581635-26213-1-git-send-email-marek.vasut@gmail.com>
References: <1281581635-26213-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTimuLjGo7O1kWXq0XbTns4EV2e5q5o0esNns1BY9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 22:53, Marek Vasut wrote:
> These three platforms didn't properly fill nr_chips in gen_nand registration and
> therefore depended on gen_nand bug fixed by the following patch:

the Blackfin arch has a mailing list ... no need to pick out people

> "mtd: gen_nand: fix support for multiple chips"
>
> ?arch/blackfin/mach-bf537/boards/stamp.c ? | ? ?1 +
> ?arch/blackfin/mach-bf561/boards/acvilon.c | ? ?1 +

looks sane enough to me
Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
