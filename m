From: jesse.barker@linaro.org (Jesse Barker)
Date: Wed, 16 Feb 2011 06:42:10 -0800
Subject: [PATCH] i.MX23/28 framebuffer driver
In-Reply-To: <201102161322.08126.arnd@arndb.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091731.07794.arnd@arndb.de>
	<AANLkTikhcphz_8TS4L+z2heayqnJbK1NEW8DzqTm=YKp@mail.gmail.com>
	<201102161322.08126.arnd@arndb.de>
Message-ID: <AANLkTik+ounqcTJ6rhiUqKPGkwcCOKGXdsVADs6zHfPU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Speaking for the Linaro graphics working group, I think it's great.  And, I
think you're right, that if enough of the KMS support in xf86-video-* is
similar enough (I was only aware of intel and nouveau supporting it properly
at current), pulling it out into a common layer would make it easier to
support in new drivers (including fbdev).

cheers,
Jesse

On Wed, Feb 16, 2011 at 4:22 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 15 February 2011, Clark, Rob wrote:
> > I'd been experimenting a bit on the side w/ the DRM driver framework (
> >
> http://gitorious.com/~robclark/pandaboard/robclarks-kernel-omap4/commits/omap_gpu
> > ), but had to add a good chunk of mostly boilerplate code to our xorg
> > driver in order just to test it.  Maybe some generic support for KMS
> > in xf86-video-fbdev would have made this easier to develop the kernel
> > part without in parallel having to implement the userspace part.  I'm
> > not sure if this is the sort of thing the linaro-wg has in mind?
>
> I'm not sure what the the linaro multimedia wg thinks of this, but the
> kernel code you linked looks like it's doing exactly the right thing.
>
>        Arnd
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110216/78490466/attachment-0001.html>
