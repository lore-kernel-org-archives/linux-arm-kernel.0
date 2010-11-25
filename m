From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 25 Nov 2010 16:56:14 +0300
Subject: [PATCH v2 2/3] ARM: cns3xxx: Add architecture definition for
	EHCI/OHCI controller
In-Reply-To: <AANLkTikDFe55ksjia85WSecsUw+VQpYnVO-xCkhdmcYO@mail.gmail.com>
References: <1290443565-20766-1-git-send-email-mkl0301@gmail.com>
	<1290443565-20766-3-git-send-email-mkl0301@gmail.com>
	<20101124161122.GA15902@oksana.dev.rtsoft.ru>
	<AANLkTimMEALmH08RKQet_MGiyEFYpD2kVtPtmKJpmhtZ@mail.gmail.com>
	<20101125104817.GA31779@oksana.dev.rtsoft.ru>
	<AANLkTikDFe55ksjia85WSecsUw+VQpYnVO-xCkhdmcYO@mail.gmail.com>
Message-ID: <20101125135614.GA22212@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 09:51:23PM +0800, Lin Mac wrote:
> 2010/11/25 Anton Vorontsov <cbouatmailru@gmail.com>:
> > On Thu, Nov 25, 2010 at 03:25:38PM +0800, Lin Mac wrote:
> > [...]
> >> > ?#include <linux/module.h>
> >> > ?#include <linux/io.h>
> >> > ?#include <linux/delay.h>
> >> > +#include <asm/atomic.h>
> >> It's not necessary for mach/pm.h already included it, right?
> >
> > Technically, it's not necessary. But in Linux we don't rely on
> > headers including other headers. Think that someday mach/pm.h
> > may not include asm/atomic.h, so the build will break.
> >
> > Thanks,
> 
> Get it. So should I re-submit all 3 patches, or just the last one?

Just the last one, thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
