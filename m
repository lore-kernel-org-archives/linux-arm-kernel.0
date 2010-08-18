From: roundrobinjp@yahoo.co.jp (Round Robinjp)
Date: Wed, 18 Aug 2010 21:12:50 +0900 (JST)
Subject: DMA memory: can it be returned back to the system
Message-ID: <856809.71230.qm@web4203.mail.ogk.yahoo.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Our device requires 10M of physically contiguous RAM.
The memory is needed for short time and then can be
returned back to the system.

My question is: if I use DMA for this purpose is there
any way to return the memory back to the system so that
the system can use that memory for other purposes such as
for application mallocs.

Thanks
RR

--------------------------------------
GyaO! - Anime, Dramas, Movies, and Music videos [FREE]
http://pr.mail.yahoo.co.jp/gyao/
