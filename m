From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 05 Feb 2016 22:04:44 +0100
Subject: marvell_cesa fails to register on kirkwood (88F6282)
In-Reply-To: <8760y2vqje.fsf@natisbad.org> (Arnaud Ebalard's message of "Fri,
 05 Feb 2016 21:41:09 +0100")
References: <CAKzmTe0mvZD5UwqM47uXbM7Z7oAJpE4g4BVMba1hkzqNu+Zbgw@mail.gmail.com>
 <20160205090246.GE32272@lunn.ch> <20160205112907.796afb05@bbrezillon>
 <CAKzmTe20fT8BcRaDaf2gz92KMAK0kEUkaD-kPq_cPF1WKBdroA@mail.gmail.com>
 <87vb632maf.fsf@free-electrons.com>
 <CAKzmTe1AqNQwjcsAULotd010NXuk1AYjj5p6UoqT_Zu=BCHdcw@mail.gmail.com>
 <87mvrf2l6p.fsf@free-electrons.com>
 <87io232kat.fsf@free-electrons.com> <8760y2vqje.fsf@natisbad.org>
Message-ID: <87twlmdg2b.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> I'll try and do the same now w/ CESA support compiled as module to see
> what I get. I'll keep you posted.

root at mood:~# insmod /tmp/marvell-cesa.ko 
[  573.897977] marvell-cesa f1030000.crypto: CESA device successfully registered

root at mood:~# uname -a
Linux mood 4.4.0.duov2 #2 Fri Feb 5 21:42:49 CET 2016 armv5tel GNU/Linux

root at mood:~# zcat /proc/config.gz | grep -i CESA
# CONFIG_CRYPTO_DEV_MV_CESA is not set
CONFIG_CRYPTO_DEV_MARVELL_CESA=m

Cheers,

a+

ps: my config is temporarily at http://natisbad.org/config-duov2-cesa
