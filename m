From: laforge@gnumonks.org (Harald Welte)
Date: Thu, 19 Nov 2009 06:47:57 +0100
Subject: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from
	Arnaud Patard.
In-Reply-To: <20091119025930.GA20172@core.coreip.homeip.net>
References: <20091118232939.201290297@fluff.org.uk>
	<20091118232948.063635416@fluff.org.uk>
	<20091119025930.GA20172@core.coreip.homeip.net>
Message-ID: <20091119054757.GE13105@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Dmitry,

On Wed, Nov 18, 2009 at 06:59:30PM -0800, Dmitry Torokhov wrote:

> Thank you for the patch. First thing first - do we have an agreement
> from all Samsung folks and other interested parties that _this_ is the
> driver? Because it's like 3rd implementation that came across...

I think it is important we finally merge _a_ driver, giving users a useful
touchscreen after many, many years of delay.  Whoever has issues with that
driver should simply address those issues and propose incremental patches to
it.

This is speaking with both my former Openmoko "hat" as well as considering
what is most important for Samsung System LSI.

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
