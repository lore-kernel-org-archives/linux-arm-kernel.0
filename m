From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 29 May 2013 12:06:44 -0400 (EDT)
Subject: [PATCH] ARM: fix kernel decompressor compilation error with
 CONFIG_DEBUG_SEMIHOSTING
In-Reply-To: <20130529145944.GE29528@S2101-09.ap.freescale.net>
References: <alpine.LFD.2.03.1305281654120.1918@syhkavp.arg>
 <20130529145944.GE29528@S2101-09.ap.freescale.net>
Message-ID: <alpine.LFD.2.03.1305291205330.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Shawn Guo wrote:

> On Tue, May 28, 2013 at 04:59:13PM -0400, Nicolas Pitre wrote:
> > 
> > ... and add semihosting output support to the decompressor while at it.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Thanks.

> Maybe include the error output in commit log.

Yes, and I've improved it as well.

Patch queued as 7737/1.


Nicolas
