From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Jul 2010 09:52:23 +0900
Subject: About cachetype on ARMv7
In-Reply-To: <20100707074943.GA21884@n2100.arm.linux.org.uk>
References: <004c01cb1c34$49773f60$dc65be20$%kim@samsung.com>
	<20100705141719.GA23556@n2100.arm.linux.org.uk>
	<013501cb1d6a$47682ea0$d6388be0$%kim@samsung.com>
	<20100707074943.GA21884@n2100.arm.linux.org.uk>
Message-ID: <01c101cb1e37$d60e7f60$822b7e20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
> On Wed, Jul 07, 2010 at 09:20:57AM +0900, Kukjin Kim wrote:
> > > The requirements for N is such the CPU visible conditions which
qualify a
> > > cache as being VIPT non-aliasing also satisfy PIPT - and a
non-aliasing
> > > VIPT cache has the same properties as a PIPT cache.
> >
> > Thanks for your reply :-)
> >
> > You mean PIPT is the same as VIPT non-aliasing.
> 
> No, because that's not the case - they are different at the hardware
> level.  At the software level, they can be treated the same though.
> 
Yes, you're right. I meant from a functionality point of view in the Linux
kernel.

> > Hmm..there is no need to show exactly cachetype in the kernel boot
message?
> 
> The boot message shows how the kernel drives the cache, not what the
> actual cache is - which is far more informative about what the kernel
> is doing.
> 
I see.

> We can find out what the hardware is by looking in specification docs;
> we don't need the kernel to tell us that.

I agree with you in principle.
But I think, it would be helpful to someone if it could be shown more exact
feature in the kernel boot message especially in this case, it differs with
actual hardware information.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
