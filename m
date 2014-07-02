From: gorcunov@gmail.com (Cyrill Gorcunov)
Date: Wed, 2 Jul 2014 23:07:06 +0400
Subject: [patch 3/4] timerfd: Implement timerfd_ioctl method to restore
 timerfd_ctx::ticks
In-Reply-To: <4188254.Av1Z2pQssC@wuerfel>
References: <20140623185431.396309193@openvz.org>
 <53B4382F.9030908@codeaurora.org> <20140702170416.GG12440@moon>
 <4188254.Av1Z2pQssC@wuerfel>
Message-ID: <20140702190706.GH12440@moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 09:01:02PM +0200, Arnd Bergmann wrote:
> > > 
> > > 64-bit get_user is currently unsupported on ARM, although it appears work is
> > > ongoing [1].
> > > 
> > > 1. https://lkml.org/lkml/2014/6/17/260
> > 
> > Thanks for info, Christopher! What arm camp is using then, copy-from-user?
> > 
> 
> copy_from_user should work on all architectures. I believe a 64-bit get_user
> is currently unsupported on most 32-bit architectures, x86-32 being a notable
> exception.

Thanks, I'll update.
