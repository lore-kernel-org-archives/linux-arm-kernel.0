From: luciano.coelho@nokia.com (Luciano Coelho)
Date: Thu, 16 Sep 2010 21:35:39 +0300
Subject: [PATCH v6 01/17] wl12xx: make wl12xx.h common to both spi and sdio
In-Reply-To: <1284635762-12335-1-git-send-email-ohad@wizery.com>
References: <AANLkTikYd+TojQC-R+Vrdou6KSRwFNczBeTnsX7eTDn4@mail.gmail.com>
	<1284635762-12335-1-git-send-email-ohad@wizery.com>
Message-ID: <1284662139.8951.7.camel@powerslave>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-16 at 13:16 +0200, ext Ohad Ben-Cohen wrote:
> Move wl12xx.h outside of the spi-specific location,
> so it can be shared with both spi and sdio solutions.
> 
> Update all users of spi/wl12xx.h accordingly
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---

Acked-by: Luciano Coelho <luciano.coelho@nokia.com>

I just wonder why the wl12xx.h move wasn't detected as a rename.  Did
you forget to use the -M option in format-patch?

-- 
Cheers,
Luca.
