From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jan 2012 17:35:05 +0000
Subject: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
In-Reply-To: <1326749786-13035-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1326749786-13035-1-git-send-email-maxime.ripard@free-electrons.com>
 <1326749786-13035-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201201171735.06166.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 January 2012, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

I think I reviewed this driver before, but I don't remember any of the
details I may have complained about. I assume everything was fixed,
since the driver looks good in this version ;-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

Two general comments:

* Please add a changeset description (i.e. thetext above your
Signed-off-by: line) for every patch you do. Just read a few
dozen patches that get posted to lkml to get a feeling for
what would be useful to have in there. For a new driver, it
would be helpful to know what hardware uses this driver and
what the device does there.

* Over time, we will get stricter in requiring device tree
bindings for new platform devices, to replace platform_data
where appropriate. It's not required yet, but it would be nice
to describe the long-term plan in submissions that add new
platform_data but no device tree bindings.

	Arnd
