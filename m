From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 10:55:05 +0200
Subject: [RESEND PATCH v4] thermal: tango: add resume support
In-Reply-To: <57CFD031.7020500@sigmadesigns.com>
References: <57CFD031.7020500@sigmadesigns.com>
Message-ID: <6763387.6QdSyfOt0d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 10:30:41 AM CEST Marc Gonzalez wrote:
> When this platform is suspended, firmware powers the entire SoC down,
> except a few hardware blocks waiting for wakeup events. There is no
> context to save for this particular block.
> 
> Therefore, there is nothing useful for the driver to do on suspend;
> so we define a NULL suspend hook. On resume, the driver initializes
> the block exactly as is done in the probe callback.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
