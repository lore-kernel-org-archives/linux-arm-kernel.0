From: davem@davemloft.net (David Miller)
Date: Fri, 26 Feb 2010 01:20:57 -0800 (PST)
Subject: [PATCH][KS8695] Mark network interface as running on ifconfig up
In-Reply-To: <4B82A72E.50508@visionsystems.de>
References: <4B73E62B.3030305@visionsystems.de>
	<20100216.160647.208330407.davem@davemloft.net>
	<4B82A72E.50508@visionsystems.de>
Message-ID: <20100226.012057.51272829.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Date: Mon, 22 Feb 2010 16:47:58 +0100

> [KS8695] Don't call netif_carrier_off() from ndo_stop()
> 
> netif_carrier_on() and netif_carrier_off() should be called from
> link status interrupt handler
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Looks good, applied.

Please do not put text you want to make it into the
commit message header line in brackets "[]", those
get removed by automated tools that apply patches
because patches are usually posted as:

Subject: [PATCH N/M] xxxx

and the GIT tools kill all the text inside of the brackets
so that the commit header properly reads "xxx"

Thanks.
