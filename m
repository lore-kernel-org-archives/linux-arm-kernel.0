From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 19 Apr 2010 11:43:51 +0100
Subject: s3c24xx gpiolib support
In-Reply-To: <201004171332.13596.anarsoul@gmail.com>
References: <201004171332.13596.anarsoul@gmail.com>
Message-ID: <20100419104350.GA6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 17, 2010 at 01:32:09PM +0300, Vasily Khoruzhick wrote:
> Hi, Ben
> 
> Earlier you mentioned that you're planning to remove s3c24xx-specific GPIO API 
> and leave only gpiolib, but I don't see a way to configure pin to special 
> function mode via gpiolib, so I'd like to know how to switch pin to special 
> function mode?

At the moment, the s3c gpio set/get calls are pretty much gone, and will
be removed in the next kernel round unless there is some sort of show-stopper.

The configuration calls will be left, as there is no current replacement
for them.

> And what is the status of Christian's patches to add support for bank H and J 
> to gpiolib?

I'll sort them when I get around to looking at them again

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
