From: rui.zhang@intel.com (Zhang Rui)
Date: Sun, 18 Sep 2016 09:58:05 +0800
Subject: [RESEND PATCH v4] thermal: tango: add resume support
In-Reply-To: <57D96E5E.6070102@sigmadesigns.com>
References: <57CFD031.7020500@sigmadesigns.com> <6763387.6QdSyfOt0d@wuerfel>
 <57D96E5E.6070102@sigmadesigns.com>
Message-ID: <1474163885.3425.0.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?, 2016-09-14 at 17:35 +0200, Marc Gonzalez wrote:
> On 07/09/2016 10:55, Arnd Bergmann wrote:
> 
> > 
> > On Wednesday, September 7, 2016 10:30:41 AM CEST Marc Gonzalez
> > wrote:
> > 
> > > 
> > > When this platform is suspended, firmware powers the entire SoC
> > > down,
> > > except a few hardware blocks waiting for wakeup events. There is
> > > no
> > > context to save for this particular block.
> > > 
> > > Therefore, there is nothing useful for the driver to do on
> > > suspend;
> > > so we define a NULL suspend hook. On resume, the driver
> > > initializes
> > > the block exactly as is done in the probe callback.
> > > 
> > > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> > > Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Hello Rui, Eduardo,
> 
> The present patch has been reviewed by both Kevin Hilman and Arnd
> Bergmann,
> two arm-soc maintainers. Can you pick it up in time for inclusion in
> v4.9?

It has already been in thermal -release branch for a while, and queued
for 4.9.

thanks,
rui
> 
> Regards.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at??http://vger.kernel.org/majordomo-info.html
