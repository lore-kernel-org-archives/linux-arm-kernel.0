From: luciano.coelho@nokia.com (Luciano Coelho)
Date: Thu, 16 Sep 2010 23:00:59 +0300
Subject: [PATCH v6 01/17] wl12xx: make wl12xx.h common to both spi and sdio
In-Reply-To: <AANLkTinQ3EVOTjfnOy7EXP==b=tpSicDdokBAZ67Lc7O@mail.gmail.com>
References: <AANLkTikYd+TojQC-R+Vrdou6KSRwFNczBeTnsX7eTDn4@mail.gmail.com>
	<1284635762-12335-1-git-send-email-ohad@wizery.com>
	<1284662139.8951.7.camel@powerslave>
	<AANLkTinQ3EVOTjfnOy7EXP==b=tpSicDdokBAZ67Lc7O@mail.gmail.com>
Message-ID: <1284667259.8951.75.camel@powerslave>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-16 at 21:56 +0200, ext Ohad Ben-Cohen wrote:
> On Thu, Sep 16, 2010 at 8:35 PM, Luciano Coelho
> <luciano.coelho@nokia.com> wrote:
> > Acked-by: Luciano Coelho <luciano.coelho@nokia.com>
> >
> > I just wonder why the wl12xx.h move wasn't detected as a rename.  Did
> > you forget to use the -M option in format-patch?
> 
> I thought it's because I stripped the SPI_ from the
> #ifndef _LINUX_SPI_WL12XX_H, but it should be smarter than that.
> Probably the -M.

Yes, it is smarter than that.  With small changes like this, -M will
still show it as a rename and show the diff instead of the whole file
-ed and +ed back ;)

-- 
Cheers,
Luca.
