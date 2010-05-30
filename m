From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 30 May 2010 09:54:30 +0200
Subject: 2.6.34 hangs during boot on PB11MPCore
In-Reply-To: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
References: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
Message-ID: <AANLkTinCN-vZvRxR-WGQdbTwpgnjG22tepVk5vFB3mmB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/30 Bjoern Brandenburg <bbb.lst@gmail.com>:

> we're having a bit of trouble to get 2.6.34 to run on a PB11MPCore board with
> SMP enabled. If we don't specify maxcpus=1, then the system gets stuck when
> trying to launch init (via NFS).

I had the same problem earlier on the -next tree. However I thought it was
all my fault for some reason and used the defconfig with SMP disabled.
Now I can't access the machine for the moment :-/

Yours,
Linus Walleij
