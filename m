From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 3 Sep 2013 13:19:54 +0200
Subject: [PATCHv6 1/2] ARM: sunxi: Initial support for Allwinner's
 Security ID fuses
In-Reply-To: <20130902161232.GA23912@kroah.com>
References: <1378035019-9649-1-git-send-email-oliver+list@schinagl.nl>
 <1378035019-9649-2-git-send-email-oliver+list@schinagl.nl>
 <20130902080812.GA2630@lukather> <20130902161232.GA23912@kroah.com>
Message-ID: <20130903111954.GB2630@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Mon, Sep 02, 2013 at 09:12:32AM -0700, Greg KH wrote:
> > What I wanted was a (pretty long, I agree) summing up the whole
> > discussion we had.
> > 
> > Something like:
> > 
> > /*
> >  * Be aware that this will generate a race with userspace. By the time
> >  * it gets called, udev has already been notified of the device
> >  * addition, and will never be notified that this file has been added.
> >  *
> >  * It should be properly fixed by having some way to attach a sysfs
> >  * attribute group to the device structure before the probe.
> >  * Unfortunately, this is both not possible for platform devices at the
> >  * moment and not trivial to do, so this will need a proper fix later
> >  * on.
> >  */
> > 
> > And just like the comment quoted above, you can remove the useless fixme
> > comments you added everywhere.
> 
> There's no need for any of this, including the "FIXME" comments.  I know
> what the problem is here, and until the driver core changes get merged
> upstream in order to fix it, there's no need to worry about "broken"
> drivers, as everything is "broken".
> 
> I'll just take this as-is and remove the "fixme" comments, ok?

It's your call :)

We had a few other comments, that will probably be fixed in the v7
oliver just sent, so you'd probably want to merge the v7 instead.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130903/abf0d2db/attachment.sig>
