From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 6 Mar 2014 12:46:30 +0100 (CET)
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140226221939.GC21483@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <Pine.LNX.4.64.1402262144190.10826@axis700.grange>
 <20140226221939.GC21483@n2100.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.1403061241560.30001@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Sorry for a long delay.

On Wed, 26 Feb 2014, Russell King - ARM Linux wrote:

[snip]

> Better bindings for imx-drm are currently being worked on.  Philipp
> Zabel of Pengutronix is currently looking at it, and has posted many
> RFC patches on this very subject, including moving the V4L2 OF helpers
> to a more suitable location.  OF people have been involved in that
> discussion over the preceding weeks, and there's a working implementation
> of imx-drm using these helpers from v4l2.

Yes, I'm aware of that patch series, and I do look at the discussion from 
time to time, unfortunately I don't have too much time for it now. But in 
any case if this work is going to be used with imx-drm too, that should be 
a good direction to take, I think.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
