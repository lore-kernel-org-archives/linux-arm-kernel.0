From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 10 Feb 2015 09:17:12 +0100
Subject: Continuing kallsyms failures - large kernels, XIP kernels, and
 large XIP kernels
In-Reply-To: <20150206161428.GZ8656@n2100.arm.linux.org.uk>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
 <20150130153414.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501301224180.1322@knanqh.ubzr>
 <20150131002253.GR26493@n2100.arm.linux.org.uk>
 <20150204000307.GA8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502032054460.1322@knanqh.ubzr>
 <20150204094414.GC8656@n2100.arm.linux.org.uk>
 <20150205084323.GS10842@pengutronix.de>
 <20150206142033.GB10842@pengutronix.de>
 <20150206161428.GZ8656@n2100.arm.linux.org.uk>
Message-ID: <20150210081712.GA3410@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, Feb 06, 2015 at 04:14:28PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 06, 2015 at 03:20:33PM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Feb 05, 2015 at 09:43:23AM +0100, Uwe Kleine-K?nig wrote:
> > > An unmodified 3.19.0-rc6 + efm32_defconfig boots just fine with XIP (and
> > > has to little RAM for holding the kernel image in it's 4 MiB RAM).
> > And btw next fails to build because of your patch
> > 51f36035999ca403d08304176bdfa288a549b50e. Maybe you can limit it to MMU
> > configs only to prevent false positives?
> 
> I'm intending to drop that patch; I think it's far too difficult to try
> and modify vmlinux.lds to be able to detect these kinds of overflows,
> which is a real shame.
I guess you didn't change your mind and just didn't come around yet to
drop this patch?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
