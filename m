From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 May 2015 10:37:39 +0200
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <5549CEAF.1090400@linaro.org>
References: <55417F5A.4040300@linaro.org> <2196079.901rMdSZr0@wuerfel>
 <5549CEAF.1090400@linaro.org>
Message-ID: <3443848.jTbkmjUfGI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 May 2015 16:19:59 Shannon Zhao wrote:
> > How about Ubuntu or Debian releases that do not use systemd?
> > 
> > I guess we should check with a Debian Wheezy or Ubuntu Trusty release.
> > My guess is that it will work fine, but some minor adjustment might
> > be needed.
> 
> Will check Debian Wheezy and Ubuntu Trusty release later.
> BTW, I don't have them on hand, where can I get these filesystem for ARM?
> 

I think these should work for Debian:

https://people.debian.org/~aurel32/qemu/armhf/

but you will have to provide a newer kernel.

The image is a 32-bit user space, but it should work with both 32-bit
and 64-bit kernels. It's probably enough to test either ubuntu or
debian.

	Arnd
