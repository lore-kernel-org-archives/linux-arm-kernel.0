From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 12 Jul 2013 14:06:43 +0200
Subject: v3.10 - big endian core support
In-Reply-To: <51DFEF75.8080600@codethink.co.uk>
References: <CALicx6u89THSiRa4FzGZrcoG8q+o_BD8qVEC4CYXEjPUVK_fJw@mail.gmail.com>
 <20130712134726.0a909165@skate> <51DFEF75.8080600@codethink.co.uk>
Message-ID: <20130712140643.2a3f1c68@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Fri, 12 Jul 2013 12:58:45 +0100, Ben Dooks wrote:

> > Yeah, the Thumb2 code is not supported by Ben Dooks patches, it's part
> > of the TODO-list. I think Ben said he would probably not have much time
> > to work on this. I might be able to spare some time on this, so just
> > let me know if I should start working on this. If I remember correctly,
> > it's mainly the fixup_pv_table code that needed some Thumb2/BE love.
> >
> > Will, is getting Thumb2 working a requirement to get the BE support
> > merged, or can we for now make the BE option depends on !THUMB2_KERNEL ?
> 
> I would like to sort out getting this code merged as it seems to have
> been tested by several people now outside Codethink.

I briefly talked with Will this week at LCE, and apparently he was
generally ok with the patches. He only mentioned that the series should
be split between core ARM stuff (that goes through Russell's tree), and
the platform-specific changes, that go through the different
maintainers tree.

> I could try doing the THUMB2 support, but I do not have a lot of
> experience with building THUMB2 kernels.

Ok. Let me know if you need some help. I'd really like to see this BE
work make it into 3.12.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
