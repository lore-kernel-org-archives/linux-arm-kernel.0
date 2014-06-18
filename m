From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 18 Jun 2014 23:43:44 +0300
Subject: [PATCH] omap3-n900.dts: Rename model name to "Nokia RX-51 board"
In-Reply-To: <201406182223.03420@pali>
References: <1403110635-29696-1-git-send-email-pali.rohar@gmail.com>
 <20140618201241.GB558@drone.musicnaut.iki.fi>
 <201406182223.03420@pali>
Message-ID: <20140618204344.GC558@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 18, 2014 at 10:23:03PM +0200, Pali Roh?r wrote:
> On Wednesday 18 June 2014 22:12:41 Aaro Koskinen wrote:
> > On Wed, Jun 18, 2014 at 06:57:15PM +0200, Pali Roh?r wrote:
> > > Use same name as in legacy board code. There are lot of
> > > userspace applications which using machine/model name for
> > > determinating device type.
> > 
> > Can you clarify this? Nokia kernel or userspace never had DT,
> > so they cannot see e.g. /proc/device-tree/model. What other
> > APIs expose model?
> 
> Basically that patch export model name in Hardware /proc/cpuinfo 
> instead generic DT name. And this patch change name to what 
> legacy board code reported.

I don't like the idea of changing the model name from Nokia
marketing names to those cryptic internal names in DT files.
There also may be already some userspace relying to find current model
name from /proc/device-tree/model (e.g. I think my own OS would break).

A.
