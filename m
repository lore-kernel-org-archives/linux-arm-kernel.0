From: giometti@enneenne.com (Rodolfo Giometti)
Date: Thu, 2 Jan 2014 13:44:07 +0100
Subject: NAND support for Armada 370
Message-ID: <20140102124407.GF10251@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gregory,

I'm working on vanilla kernel 3.13-rc6 and an Armada-370 based board
(compatible with armada-370-db) and I'm trying to get NAND support
working.

I noticed that on my kernel is missing your patch named "[PATCH v2
01/27] clk: mvebu: Add Core Divider clock", however after applying it
I get:

   pxa3xx-nand f10d0000.nand: This platform can't do DMA on this device
   pxa3xx-nand f10d0000.nand: Wait time out!!!
   pxa3xx-nand f10d0000.nand: Wait time out!!!
   pxa3xx-nand f10d0000.nand: Wait time out!!!
   No NAND device found

Do I still miss something? And what about DMA support?

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
