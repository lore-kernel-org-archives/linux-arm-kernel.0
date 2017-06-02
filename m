From: davem@davemloft.net (David Miller)
Date: Fri, 02 Jun 2017 10:08:01 -0400 (EDT)
Subject: [PATCH v6 00/21] net-next: stmmac: add dwmac-sun8i ethernet driver
In-Reply-To: <20170602063752.aqyvwcykvepiyt4y@flea.lan>
References: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
 <20170601.145819.789604139072328057.davem@davemloft.net>
 <20170602063752.aqyvwcykvepiyt4y@flea.lan>
Message-ID: <20170602.100801.2029534530888525251.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 2 Jun 2017 08:37:52 +0200

> On Thu, Jun 01, 2017 at 02:58:19PM -0400, David Miller wrote:
>> From: Corentin Labbe <clabbe.montjoie@gmail.com>
>> Date: Wed, 31 May 2017 09:18:31 +0200
>> 
>> > This patch series add the driver for dwmac-sun8i which handle the Ethernet MAC
>> > present on Allwinner H3/H5/A83T/A64 SoCs.
>> 
>> Series applied, but wow that's a lot of DT file changes :-(
> 
> The DT patches should not go through your tree, but arm-soc, so I
> guess this is not an issue for you?

I already applied them, so if that is the intention, too late.

This needs to be explicitly stated in the header posting.  Otherwise
I assume the entire series is meant to go into my tree.

Also, saying "net-next" in the patch subjects means it's targetting my
tree.
