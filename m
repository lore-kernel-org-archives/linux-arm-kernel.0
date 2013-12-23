From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Dec 2013 16:28:43 +0800
Subject: [PATCH] video: imxfb: Use regulator API with LCD class for
 powering
In-Reply-To: <1387787053.605757144@f413.i.mail.ru>
References: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
 <20131223082107.GF26070@S2101-09.ap.freescale.net>
 <1387787053.605757144@f413.i.mail.ru>
Message-ID: <20131223082842.GI26070@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 12:24:13PM +0400, Alexander Shiyan wrote:
> > On Sat, Dec 21, 2013 at 03:08:00PM +0400, Alexander Shiyan wrote:
> > > This patch replaces custom lcd_power() callback with
> > > regulator API over LCD class.
> > 
> > FYI.  Denis' effort on this already goes to v13.
> > 
> > http://thread.gmane.org/gmane.linux.ports.arm.kernel/285326
> 
> Hmm, OK, but having LCD class could resolve our problems with contrast control.
> https://www.mail-archive.com/devicetree at vger.kernel.org/msg07660.html

I just want to make sure you two are aware of each other's work.

Shawn
