From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Mar 2017 17:06:59 +0200
Subject: [GIT PULL 1/3]: DaVinci SoC updates for v4.12
In-Reply-To: <20170323105106.20144-1-nsekhar@ti.com>
References: <20170323105106.20144-1-nsekhar@ti.com>
Message-ID: <6686222.dYsXbxTjhl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 23, 2017 4:21:04 PM CEST Sekhar Nori wrote:
> v4.12 SoC updates for DaVinci include necessary pdata-quirks
> to make video capture and display work on da850.
> 
> VPIF driver which supports video capture and display on
> da850 is a legacy driver.  It does not have DT equavalents
> for all things that are used on platform data.
> 
> Attempts were made to pass data via DT[1], but linux-media
> does not yet have a good way of describing subdevices in
> device tree. This is work in progress. As soon as bindings
> are defined and implementation is available, we can shift
> to using that. For now we are stuck with using pdata.
> 
> The pull request also has some clean-up for PM, and a fix
> for pdata quirks mechanism.
> 
> [1] https://marc.info/?l=devicetree&m=147982998517384
> 

Pulled into next/soc, thanks!

	Arnd
