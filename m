From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 16 Sep 2010 21:56:57 +0200
Subject: [PATCH v6 01/17] wl12xx: make wl12xx.h common to both spi and sdio
In-Reply-To: <1284662139.8951.7.camel@powerslave>
References: <AANLkTikYd+TojQC-R+Vrdou6KSRwFNczBeTnsX7eTDn4@mail.gmail.com>
	<1284635762-12335-1-git-send-email-ohad@wizery.com>
	<1284662139.8951.7.camel@powerslave>
Message-ID: <AANLkTinQ3EVOTjfnOy7EXP==b=tpSicDdokBAZ67Lc7O@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 8:35 PM, Luciano Coelho
<luciano.coelho@nokia.com> wrote:
> Acked-by: Luciano Coelho <luciano.coelho@nokia.com>
>
> I just wonder why the wl12xx.h move wasn't detected as a rename. ?Did
> you forget to use the -M option in format-patch?

I thought it's because I stripped the SPI_ from the
#ifndef _LINUX_SPI_WL12XX_H, but it should be smarter than that.
Probably the -M.

Thanks,
Ohad.


>
> --
> Cheers,
> Luca.
>
>
