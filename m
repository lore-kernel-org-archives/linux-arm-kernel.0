From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Apr 2013 14:51:20 +0100
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <1365508916.24306.17.camel@hornet>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <4B3FD561-84FC-40CD-B747-13851692D673@gmail.com>
 <521DFDFC-7E9E-47EA-ACDA-C91BBDC8454E@gmail.com>
 <201304072323.42173.arnd@arndb.de>
 <CACRpkda9Nue-8Esp3cJ6u2-MJ2ZL8hH-2BnrhHwWv4GZP2VR5w@mail.gmail.com>
 <1365508916.24306.17.camel@hornet>
Message-ID: <20130409135120.GC14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 01:01:56PM +0100, Pawel Moll wrote:
> So I have PL111 code almost working here, however today it depends on
> not-yet-upstream (to my knowledge) generic/common panel/display
> framework. If I'm not disturbed again I may get something done this
> week, hopefully removing the dependency.
> 
> There's also some work going on on a DRM driver for PL111, but I can't
> promise any dates.
> 
> As to PL110 I have no idea how different is it from the PL111, but
> nothing is happening about it anyway.

If you're doing PL111, then you might as well do PL110, because the two
are basically the same.  But note that all PL111's aren't equal.  Some
are closer to PL110 than the current PL111, so if you want to support
all PL111s, you also need to have the support in place for PL110.

Also note that the way the bits are assigned in the frame buffer varies
between platforms, and most certainly the TRMs documentation of colour
bitfield layouts can _not_ be relied upon.

I have considerable knowledge in this area, but as seems to be the norm
now, no one cares about that.  I'll go back to twiddling my thumbs now,
waiting for the next email to arrive.  Or maybe I'll go down to the
shops and wander around down there.  Or something.
