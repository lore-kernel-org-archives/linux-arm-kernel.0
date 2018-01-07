From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 07 Jan 2018 21:55:33 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20180103215206.5d85b41b@bbrezillon> (Boris Brezillon's message
 of "Wed, 3 Jan 2018 21:52:06 +0100")
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon> <877etkecig.fsf@belgarion.home>
 <20171218092535.2ca1fe13@xps13> <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon> <87lghucykr.fsf@belgarion.home>
 <20171222222441.0fd77df9@bbrezillon> <20171222233730.68d9cb9d@xps13>
 <87k1xdblxf.fsf@belgarion.home> <20171223155709.2ba16e95@xps13>
 <87fu81bc45.fsf@belgarion.home> <20180102120326.7a2cf1d1@xps13>
 <87d12scbiy.fsf@belgarion.home> <20180103084037.422b239a@xps13>
 <878tded89m.fsf@belgarion.home> <20180103211028.619cd16d@bbrezillon>
 <20180103215206.5d85b41b@bbrezillon>
Message-ID: <874lnxcrsq.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> On Wed, 3 Jan 2018 21:10:28 +0100
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>> Hm, that's weird. Can you try with the old driver (pxa3xx)?
Ah you're right, my NAND was damaged ...

> Alternatively, you can type 'nand bad' from uboot to check if it
> detects the same bad blocks.
Mmmh no, the SPL is barebox in my case. Do you have a command in linux or
barebox to do the same thing ?

Cheers.

-- 
Robert
