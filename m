From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Sun, 7 Jan 2018 22:09:11 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <874lnxcrsq.fsf@belgarion.home>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon>
 <877etkecig.fsf@belgarion.home> <20171218092535.2ca1fe13@xps13>
 <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon>
 <87lghucykr.fsf@belgarion.home>
 <20171222222441.0fd77df9@bbrezillon>
 <20171222233730.68d9cb9d@xps13> <87k1xdblxf.fsf@belgarion.home>
 <20171223155709.2ba16e95@xps13> <87fu81bc45.fsf@belgarion.home>
 <20180102120326.7a2cf1d1@xps13> <87d12scbiy.fsf@belgarion.home>
 <20180103084037.422b239a@xps13> <878tded89m.fsf@belgarion.home>
 <20180103211028.619cd16d@bbrezillon>
 <20180103215206.5d85b41b@bbrezillon>
 <874lnxcrsq.fsf@belgarion.home>
Message-ID: <20180107220911.31844b3a@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Sun, 07 Jan 2018 21:55:33 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
> 
> > On Wed, 3 Jan 2018 21:10:28 +0100
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:  
> >> Hm, that's weird. Can you try with the old driver (pxa3xx)?  
> Ah you're right, my NAND was damaged ...
> 
> > Alternatively, you can type 'nand bad' from uboot to check if it
> > detects the same bad blocks.  
> Mmmh no, the SPL is barebox in my case. Do you have a command in
> linux or barebox to do the same thing ?

Not sure, but nand -i should do the trick.
https://www.barebox.org/doc/latest/commands/hwmanip/nand.html

But I am not sure this is still relevant now we know the NAND was
damaged by the previous experiments (sorry about that). Can you put the
NAND in a clean state and report us if it is still failing?

Thanks for your help,
Miqu?l
