From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 15 Aug 2011 09:23:49 -0400 (EDT)
Subject: [PATCH 1/3] ARM: mmp: add sram allocator
In-Reply-To: <1403041.Yj2MdIhcZO@wuerfel>
References: <1313377794-26721-1-git-send-email-leoy@marvell.com>
	<1313377794-26721-2-git-send-email-leoy@marvell.com>
	<1403041.Yj2MdIhcZO@wuerfel>
Message-ID: <alpine.LFD.2.00.1108150920060.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Aug 2011, Arnd Bergmann wrote:

> Some time ago, there was talk of merging the existing sram drivers
> and creating a common driver that is easy to hook into.

Absolutely.

> What has happened with that? My feeling is that we should stop adding
> more drivers like this in the platform code but rather put an
> authoritative copy into arch/arm/mm/ or even the top-level mm/ directory
> and change over the existing drivers to hook into that one.

IIRC, this was driven by Russell.  Maybe this is a good time to revive 
discussion around it.


Nicolas
