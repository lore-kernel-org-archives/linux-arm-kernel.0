From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Jul 2014 10:41:04 +0800
Subject: gpio-mxc gpio get always returns 0 for outputs for IMX6
In-Reply-To: <CA+sos7_nHFZ6pC87CVxviuQTxTQd0-Go4zdbPrek7CWqQyWiAg@mail.gmail.com>
References: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
 <20140714070341.GC2197@dragon>
 <CA+sos7_quvZo6j9rFPvgCdYsEx6RoUNPUyvxE74K4vaNWDkGyg@mail.gmail.com>
 <20140714140526.GK2197@dragon>
 <CAJ+vNU071i=fb5r-mq_GXz_r41N1XyafCeGEiuayhbwVmQ5jAQ@mail.gmail.com>
 <20140716060152.GM2197@dragon>
 <CA+sos7_nHFZ6pC87CVxviuQTxTQd0-Go4zdbPrek7CWqQyWiAg@mail.gmail.com>
Message-ID: <20140717024103.GP2197@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 09:14:23PM +0200, Beno?t Th?baudeau wrote:
> > Instead of specifying SION setup in the config cell case by case, I
> > think we can do that directly in pin function ID for all cases where
> > GPIO mode is selected.  I just sent a patch to do that.  Please take
> > a look to see if it works for you.
> 
> I don't find this patch on the ML.

The patch is too big to hit the list.

> 
> Note that enabling SION for all pads in GPIO mode will have some
> impact on the power consumption. That's why SION is designed to be
> used on a per-pad basis, only when an output GPIO needs to be sensed.

Okay, in that case, we will have to leave the configuration option to
board DTS author.

Shawn
