From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 12 Aug 2012 19:50:12 +0100
Subject: [PATCH 04/11] MFD: twl4030-audio: Add DT support
In-Reply-To: <5023C0D6.8040600@ti.com>
References: <20120808131356.GS16861@opensource.wolfsonmicro.com>
 <50226CF4.1010202@ti.com>
 <20120808135253.GC16861@opensource.wolfsonmicro.com>
 <502274DA.9020204@ti.com>
 <20120808141849.GA24328@opensource.wolfsonmicro.com>
 <50227837.10400@ti.com>
 <20120808144933.GC24328@opensource.wolfsonmicro.com>
 <50238E8A.5030902@ti.com>
 <20120809103600.GI24328@opensource.wolfsonmicro.com>
 <5023C0D6.8040600@ti.com>
Message-ID: <20120812185012.GB10627@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 04:53:26PM +0300, Peter Ujfalusi wrote:
> On 08/09/2012 01:36 PM, Mark Brown wrote:

> > Is there any actual case where an external mute is supplied via a
> > mechanism other than a GPIO, and if there is would it not either need
> > its own DT property or already need to interact with the driver from
> > code, making the DT property redundant?

> Not with my knowledge. The only board using it is the zoom2 upstream. I know
> other boards (not in upstream) which either uses the internal mute or GPIO.

OK, so we can probably only support GPIO for now then worry about other
external mutes when there's something to work with.
