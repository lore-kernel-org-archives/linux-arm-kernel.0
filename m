From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 10 Feb 2010 13:37:18 -0700
Subject: [PATCH v2] async-tx: fix buffer sumbission error handling in
	ipu_idma.c
In-Reply-To: <Pine.LNX.4.64.1002102111170.4495@axis700.grange>
References: <Pine.LNX.4.64.1002101643390.4495@axis700.grange>
	<e9c3a7c21002100754k7737b79cvb13a2b39ad16cc44@mail.gmail.com>
	<Pine.LNX.4.64.1002101659580.4495@axis700.grange>
	<e9c3a7c21002100947y1cf32043u4ec9d2a5c4e494f8@mail.gmail.com>
	<20100210180427.GD15883@pengutronix.de>
	<Pine.LNX.4.64.1002102111170.4495@axis700.grange>
Message-ID: <e9c3a7c21002101237p60a76cbey4cebe0299171cbf0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/10 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> On Wed, 10 Feb 2010, Uwe Kleine-K?nig wrote:
>
>> Hello Guennadi,
>>
>> s/sumbission/submission/ in the Subject
>
> Right, thanks Uwe. Dan, can you fix this when committing or shall I make
> v3?

I applied it with this fix.

--
Dan
