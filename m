From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Sat, 23 Dec 2017 23:42:21 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <87fu81bc45.fsf@belgarion.home>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon>
 <877etkecig.fsf@belgarion.home> <20171218092535.2ca1fe13@xps13>
 <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon>
 <87lghucykr.fsf@belgarion.home>
 <20171222222441.0fd77df9@bbrezillon>
 <20171222233730.68d9cb9d@xps13> <87k1xdblxf.fsf@belgarion.home>
 <20171223155709.2ba16e95@xps13> <87fu81bc45.fsf@belgarion.home>
Message-ID: <20171223234221.55df01d8@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

> > Also to ease the understanding, you might add a dump_stack() right
> > next to this error message.  
> Attached in [1].

Ok, I think I have identified the issue, and I probably can reproduce
it with the board I have. I think this is a regression due to a
recent fix, when I changed the ->correct() hook to check for 0xFF bytes
also in the ECC bytes.

I will come back to you in a few days, until then, happy end of year :)

Thank you,
Miqu?l
