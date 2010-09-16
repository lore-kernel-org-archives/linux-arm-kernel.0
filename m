From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Sep 2010 13:46:48 -0700
Subject: [PATCH v6 01/17] wl12xx: make wl12xx.h common to both spi and sdio
In-Reply-To: <1284662139.8951.7.camel@powerslave>
References: <AANLkTikYd+TojQC-R+Vrdou6KSRwFNczBeTnsX7eTDn4@mail.gmail.com>
	<1284635762-12335-1-git-send-email-ohad@wizery.com>
	<1284662139.8951.7.camel@powerslave>
Message-ID: <20100916204648.GO29610@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Luciano Coelho <luciano.coelho@nokia.com> [100916 11:28]:
> On Thu, 2010-09-16 at 13:16 +0200, ext Ohad Ben-Cohen wrote:
> > Move wl12xx.h outside of the spi-specific location,
> > so it can be shared with both spi and sdio solutions.
> > 
> > Update all users of spi/wl12xx.h accordingly
> > 
> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> > ---
> 
> Acked-by: Luciano Coelho <luciano.coelho@nokia.com>

Looks good to me too:

Acked-by: Tony Lindgren <tony@atomide.com>
