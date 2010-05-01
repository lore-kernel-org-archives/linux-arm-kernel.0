From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 2 May 2010 01:48:34 +0200
Subject: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
In-Reply-To: <z2ye9c3a7c21005011628r7c0c2b5bq36126db83d3ea5e3@mail.gmail.com>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	<v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
	<t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com>
	<q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com>
	<20100422110025.GC20008@n2100.arm.linux.org.uk>
	<g2qe9c3a7c21005011500l11511d43i12d971775b139c3b@mail.gmail.com>
	<20100501224429.GA17693@n2100.arm.linux.org.uk>
	<x2u63386a3d1005011604kaee33364l880e90a4e2453e0f@mail.gmail.com>
	<z2ye9c3a7c21005011628r7c0c2b5bq36126db83d3ea5e3@mail.gmail.com>
Message-ID: <u2q63386a3d1005011648k5fa29ae9y9e03d3c94594902b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/2 Dan Williams <dan.j.williams@intel.com>:
> On Sat, May 1, 2010 at 4:04 PM, Linus Walleij

>> When the driver issues a request to perform a DMA transfer, it will pull
>> out a physical channel and use that, then return it. If there is too
>> much combat about the physical channels, you configure out DMA
>> for the least wanted PrimeCells.
>>
>
> Could you simulate this by publishing more struct dma_chans than are
> physically present, and then handle the muxing internal to the driver?
> ?Or am I misunderstanding the usage model?

Yes exactly that way. What I had in mind atleast.

Yours,
Linus Walleij
