From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Jul 2012 21:36:26 +0800
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20483.48320.888197.282702@ipc1.ka-ro>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
 <20479.59525.385001.544046@ipc1.ka-ro>
 <20120715144935.GB2429@S2100-06.ap.freescale.net>
 <20120715150003.GD2429@S2100-06.ap.freescale.net>
 <20483.48320.888197.282702@ipc1.ka-ro>
Message-ID: <20120718133624.GA30219@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 09:03:28AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> > On Sun, Jul 15, 2012 at 10:49:35PM +0800, Shawn Guo wrote:
> > > below.  But does that mean ethernet PHY does not work even on non-DT
> > > kernel right now?
> > > 
> > So I guess you need something like c46d291 (ARM: apx4devkit: fix FEC
> > enabling PHY clock) for TX28 too.
> > 
> That's already in place.
> 
Are you using and talking about the branch I prepared for you?
I haven't seen it there.

Shawn
