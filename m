From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Nov 2018 06:48:31 +0100
Subject: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
In-Reply-To: <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-7-hch@lst.de>
 <20181019122228.GJ30658@n2100.armlinux.org.uk>
 <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
 <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
Message-ID: <20181101054831.GA4589@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2018 at 01:05:26AM +0900, Masahiro Yamada wrote:
> > How about letting CONFIG_ARM to select HAVE_PCI ?
> >
> 
> 
> I applied 1/9, 3/9, 4/9, 5/9.
> (I think 2/9 should be squashed to 9/9)
> 
> As Russell pointed out, we need to avoid
> the unmet dependency.

Yes, I think the HAVE_PCI is probably the nicest way, but we'll
need to wait what Russell as the maintainer wants.

> Are you planning to send
> the updated version for 6/9 through - 9/9 ?
> 
> If so, could you please rebase 6/9
> so that it is cleanly applicable ?

Will do once I find some time after rc1.
