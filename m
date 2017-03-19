From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Mar 2017 20:50:38 +0000
Subject: [PATCH] drm/etnaviv: add etnaviv cooling device
In-Reply-To: <CAFXsbZoT22pz2CuRWaQ2M2TyomNcByHc-SfmNn6=KrfNaubnjQ@mail.gmail.com>
References: <E1cn8jj-0002mp-SO@rmk-PC.armlinux.org.uk>
 <1489582989.16018.4.camel@pengutronix.de>
 <20170315140541.GT21222@n2100.armlinux.org.uk>
 <CAFXsbZoT22pz2CuRWaQ2M2TyomNcByHc-SfmNn6=KrfNaubnjQ@mail.gmail.com>
Message-ID: <20170319205038.GA21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 19, 2017 at 01:03:42PM -0700, Chris Healy wrote:
> I don't have any input on this binary divider subject but I do want to
> bring up some observations regarding Etnaviv GPU power management that
> seems relevant.

GPU cooling isn't really to do with GPU power management, it's more
to do with helping avoid the SoC overheating, and going into emergency
shutdown.

So, it's solving a completely different problem.

However, thank you for the links, it'll be something to be researched
at some point.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
