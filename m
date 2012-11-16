From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Nov 2012 09:36:59 +0000
Subject: [PATCH 1/1] ARM: ux500: Describe UART platform registering issues
 more accurately
In-Reply-To: <20121115123341.GA14476@gmail.com>
References: <1352968401-6092-1-git-send-email-lee.jones@linaro.org>
 <201211151223.46989.arnd@arndb.de> <20121115123341.GA14476@gmail.com>
Message-ID: <201211160936.59258.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Lee Jones wrote:
> On Thu, 15 Nov 2012, Arnd Bergmann wrote:
> 
> > On Thursday 15 November 2012, Lee Jones wrote:
> > > UARTs no longer require call-back information, since the reset
> > > call-back was removed in 43b5f0d69291374f602ad8e1817f329573a59010.
> > > The only AUXDATA dependencies remaining for UARTs are DMA settings.
> > > 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > What is the state of the DMA binding now? We originally wanted to merge
> > it for 3.7, but that didn't work out, so I hope we can get it done for
> > 3.8.
> 
> It's dead. The conversation has been stale for weeks.
> 
> Perhaps you'd like to go and poke it? :)
> 

Vinod,

is there anything you are waiting for still? Should Jon resend
his latest patches to make sure we get them merged this time?

I have multiple people that want to send me patches for 3.8 based
on that work, so we are running out of time now.

	Arnd
