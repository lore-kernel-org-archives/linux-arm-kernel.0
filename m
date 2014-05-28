From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 28 May 2014 09:31:00 +0300
Subject: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
In-Reply-To: <20140527211405.GF32336@atomide.com>
References: <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
 <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com>
 <20140508233628.GJ2198@atomide.com> <536C7EA7.5000306@ti.com>
 <20140509153723.GD17814@atomide.com> <20140513213205.GB18001@atomide.com>
 <537C9FC6.8020104@ti.com> <20140521145053.GG17417@atomide.com>
 <20140527205910.GE32336@atomide.com> <20140527211405.GF32336@atomide.com>
Message-ID: <538582A4.7070104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/14 00:14, Tony Lindgren wrote:

> FYI, I'm getting this with current linux next:
> 
> omapfb omapfb: failed to allocate framebuffer
> omapfb omapfb: failed to allocate fbmem
> omapfb omapfb: failed to setup omapfb
> omapfb: probe of omapfb failed with error -12

You need the attached patch to fix linux-next's dma alloc.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mm-compaction-properly-signal-and-act-upon-lock-and-.patch
Type: text/x-patch
Size: 1115 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/f13b6755/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/f13b6755/attachment.sig>
