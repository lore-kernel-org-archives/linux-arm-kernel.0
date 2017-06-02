From: davem@davemloft.net (David Miller)
Date: Fri, 02 Jun 2017 10:22:05 -0400 (EDT)
Subject: [PATCH v6 00/21] net-next: stmmac: add dwmac-sun8i ethernet driver
In-Reply-To: <20170602091320.lyfxsanxrypfpozb@flea.lan>
References: <20170601.145819.789604139072328057.davem@davemloft.net>
 <20170602063752.aqyvwcykvepiyt4y@flea.lan>
 <20170602091320.lyfxsanxrypfpozb@flea.lan>
Message-ID: <20170602.102205.701672574727845689.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 2 Jun 2017 11:13:20 +0200

> On Fri, Jun 02, 2017 at 08:37:52AM +0200, Maxime Ripard wrote:
>> On Thu, Jun 01, 2017 at 02:58:19PM -0400, David Miller wrote:
>> > From: Corentin Labbe <clabbe.montjoie@gmail.com>
>> > Date: Wed, 31 May 2017 09:18:31 +0200
>> > 
>> > > This patch series add the driver for dwmac-sun8i which handle the Ethernet MAC
>> > > present on Allwinner H3/H5/A83T/A64 SoCs.
>> > 
>> > Series applied, but wow that's a lot of DT file changes :-(
>> 
>> The DT patches should not go through your tree, but arm-soc, so I
>> guess this is not an issue for you?
> 
> Ok, so I saw that you actually merged them. Can you revert or drop
> that merge for the DT part?
> 
> This will generate a lot of conflicts with our tree, and I'm not sure
> this would be efficient to make you take all the entirely unrelated to
> next patches.

Please tell me which specific changes to revert.

Thank you.
