From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 23:08:51 +0100
Subject: [PATCH 2/3] IXP4xx: Fix DMA masks.
In-Reply-To: <20140324145000.4098c8c7@marrow.netinsight.se>
References: <m3siq9iyt2.fsf@intrepid.localdomain>
 <m37g7liwdb.fsf@intrepid.localdomain>
 <20140324145000.4098c8c7@marrow.netinsight.se>
Message-ID: <201403262308.51849.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 March 2014, Simon K?gstr?m wrote:
> On Sun, 23 Mar 2014 01:36:48 +0100
> Krzysztof Halasa <khc@pm.waw.pl> wrote:
> 
> > Now, devices will have 32-bit default DMA masks (0xFFFFFFFF) as per DMA API.
> > 
> > Fixes:
> > $ ifconfig eth0 up
> >
> > Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
> 
> Tested-by: Simon Kagstrom <simon.kagstrom@netinsight.net>

Reverted the earlier patch and applied this one, with your Tested-by tag.
Thanks!

	Arnd
