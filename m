From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 31 Jul 2013 21:12:09 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <1999586.84BnWE5EUh@thinkpad>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1479410.BSGDrOcRvP@thinkpad> <20130731150717.GD4904@netboy>
 <1999586.84BnWE5EUh@thinkpad>
Message-ID: <20130731191209.GA8027@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 05:23:35PM +0200, Tomasz Figa wrote:
> 
> I said it many, many times, that a) and b) I proposed are just two extremes. 
> It is unlikely that an extreme solution will be the best option to choose. I 
> am strongly for something in the middle, just like I wrote in several of my 
> previous replies.
> 
> This is something that should be commented, not those extreme options.

We are saying that pursuing a) is useless because it adds pain and
complexity without adding benefit. I simply don't buy your argument
that DT makes a better platform data, but that is besides the point.

I had said, think about the users.  You said, what users?  I wrote a
clear and concise use case.  You said, lets think about a) and b) and
all the shades of gray in between.

In order to support the use case, you will have to provide a stable
ABI. You can't have a compromise solution. At the end of the day,
either you have a stable ABI, or you don't.

It was apparent to me that the arm/dt thing has been meandering around
since its inception, but what was surprising is that people were doing
this on purpose, and now they are defending this. Why can't we get a
firm commitment on having a stable ABI?

Thanks,
Richard
