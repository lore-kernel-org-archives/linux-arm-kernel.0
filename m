From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 09 Jan 2018 08:57:59 +0100
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
Message-ID: <87zi5nbh14.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

Ok I recovered my NAND.

For the next try, I'd like you to provide another "temporary patch" to disable
BBT actual writing, just to be sure. Once the driver is working properly, I'll
make another try without the temporary patch.

Tell me when a branch I can pull is ready.

Cheers.

-- 
Robert
