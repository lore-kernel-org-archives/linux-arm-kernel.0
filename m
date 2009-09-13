From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 14 Sep 2009 00:55:24 +0300
Subject: 'bx lr' vs 'mov pc,lr'
Message-ID: <94a0d4530909131455x7a33cbaaw402642fb2e63c6d6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I noticed that in 'arch/arm/lib/delay.S' we are using 'mov pc, lr'
instead of 'bx lr'. Why? It looks like 'mov pc, lr' is used all over
the place, but I can't find out what's the reason.

-- 
Felipe Contreras
