From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 14:23:38 +0200
Subject: [PATCH 24/32] dmaengine: ste_dma40: Supply full Device Tree
 parsing support
In-Reply-To: <20130418114756.GE27903@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <201304181337.32700.arnd@arndb.de> <20130418114756.GE27903@gmail.com>
Message-ID: <201304181423.38900.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> > Yes, that's probably better and more in line with what the other
> > drivers do. You could also put the fixed_chan last if that helps.
> 
> I'd rather keep the flags as the final cell if it's all the same to you?

Ok, no problem.

> > I would still like to get a confirmation that we actually still
> > require the fixed channel assignment, since it's just used
> > in one driver, and that might only be needed for some buggy
> > hardware revision if we're lucky.
> 
> Unfortunately not:
> 
> `git grep "\.use_fixed_channel" <internal_kernel> | grep true | wc -l`
> 8

I see.

	Arnd
