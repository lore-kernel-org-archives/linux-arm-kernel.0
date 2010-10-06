From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 06 Oct 2010 13:09:23 +0200
Subject: [PATCH v2] i.MX31 and i.MX35 : fix errate TLSbo65953
	and	ENGcm09472
In-Reply-To: <alpine.LFD.2.00.1010052226310.3107@xanadu.home>
References: <20101005094510.GJ28242@pengutronix.de>	<1286280012-19809-1-git-send-email-eric@eukrea.com>	<20101005183308.GX11737@pengutronix.de>
	<4CAB7D0F.9020600@eukrea.com>	<20101005194659.GY11737@pengutronix.de>
	<4CAB83C2.3040301@eukrea.com>	<20101005200414.GA11737@pengutronix.de>
	<4CAB8A2B.7020306@eukrea.com>
	<alpine.LFD.2.00.1010052226310.3107@xanadu.home>
Message-ID: <4CAC58E3.9040503@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Le 06/10/2010 04:28, Nicolas Pitre a ?crit :
> Note that, on Linux, the WFI instruction is always executed with IRQs
> off.  So you just have to turn on the cache right after the MCR before
> returning.
>
thanks for this information.

So if there is no more problem left I'll resubmit the fixed patch.

Eric
