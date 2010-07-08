From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Jul 2010 09:08:27 +0100
Subject: About cachetype on ARMv7
In-Reply-To: <01c101cb1e37$d60e7f60$822b7e20$%kim@samsung.com>
References: <004c01cb1c34$49773f60$dc65be20$%kim@samsung.com>
	<20100705141719.GA23556@n2100.arm.linux.org.uk>
	<013501cb1d6a$47682ea0$d6388be0$%kim@samsung.com>
	<20100707074943.GA21884@n2100.arm.linux.org.uk>
	<01c101cb1e37$d60e7f60$822b7e20$%kim@samsung.com>
Message-ID: <20100708080827.GB5297@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 08, 2010 at 09:52:23AM +0900, Kukjin Kim wrote:
> I agree with you in principle.
> But I think, it would be helpful to someone if it could be shown more exact
> feature in the kernel boot message especially in this case, it differs with
> actual hardware information.

I disagree.  What's interesting is how the kernel drives the cache,
not what the cache actually is - what you want to know is "the docs
say that it's a X cache, is the kernel driving it correctly" not
"can the kernel decode the cache type register and tell me what the
documentation says the cache is".

The former is what the kernel tells you today.  The latter is useless
to working out if the kernel is doing the right thing, and is just a
proof that you can decode register values to strings.
