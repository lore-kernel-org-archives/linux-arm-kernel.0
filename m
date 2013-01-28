From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Jan 2013 22:22:52 +0800
Subject: [PATCH 0/2] Uncompress debug for multiplatform
In-Reply-To: <20130128141947.GA11626@S2101-09.ap.freescale.net>
References: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
 <20130128141947.GA11626@S2101-09.ap.freescale.net>
Message-ID: <20130128142250.GB11626@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, Russell.  I meant to put your email address on To.

Shawn

On Mon, Jan 28, 2013 at 10:19:51PM +0800, Russell King wrote:
> On Thu, Jan 17, 2013 at 11:21:57PM +0800, Shawn Guo wrote:
> > It's not about running single zImage on multiple platforms with
> > uncompress debug output, but having uncompress debug work for platform
> > that DEBUG_LL is enabled for.  But still it's better than nothing.
> > 
> > Shawn Guo (2):
> >   ARM: use Kconfig to select uncompress.h
> >   ARM: use DEBUG_LL infrastructural for multiplatform uncompress debug
> 
> Just put them into patch tracker as #7633 and #7634.
> 
> Shawn
> 
