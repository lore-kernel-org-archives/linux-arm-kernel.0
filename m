From: dilinger@queued.net (Andres Salomon)
Date: Wed, 16 Feb 2011 09:00:36 -0800
Subject: [PATCH 16/17] mc13xxx: mfd_cell is now implicitly available to
	drivers
In-Reply-To: <20110216094154.GV13279@pengutronix.de>
References: <20110211181921.3d561568@queued.net>
	<20110216094154.GV13279@pengutronix.de>
Message-ID: <20110216090036.6fffed34@debxo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Feb 2011 10:41:54 +0100
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> On Fri, Feb 11, 2011 at 06:19:21PM -0800, Andres Salomon wrote:
> > 
> > The cell's platform_data is now accessed with a helper function;
> > change clients to use that, and remove the now-unused data_size.
> > 
> > Note that mfd-core no longer makes a copy of platform_data, but the
> why was this changed and where?  I'm not able to find your complete
> series via gmane.

http://permalink.gmane.org/gmane.linux.kernel/1099164
I screwed up the threading, so the patches aren't underneath that
one.  Patchwork provides them nicely, though.

Here are the relevant patches:
https://patchwork.kernel.org/patch/551241/
https://patchwork.kernel.org/patch/551251/
https://patchwork.kernel.org/patch/551261/
..through
https://patchwork.kernel.org/patch/551451/

The next series is here:
http://thread.gmane.org/gmane.linux.kernel/1100514/focus=6046
