From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Oct 2016 15:42:30 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.8 (#3)
In-Reply-To: <87insrf8aw.fsf@free-electrons.com>
References: <87intq5z0o.fsf@free-electrons.com> <4853532.G9HOlQ47QA@wuerfel>
 <87insrf8aw.fsf@free-electrons.com>
Message-ID: <6481361.Tzq3EBKYRj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 17, 2016 2:51:03 PM CEST Gregory CLEMENT wrote:
> Hi Arnd,
>  
>  On mer., sept. 21 2016, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Tuesday, September 20, 2016 6:14:47 PM CEST Gregory CLEMENT wrote:
> >> mvebu fixes for 4.8 (part 3)
> >> 
> >> - Select corediv clk for all mvebu v7 SoC
> >> - Fix clocksource for CP110 master SPI0 for Armada 7K/8K
> >> 
> >
> > Pulled into fixes, thanks!
> 
> I don't see this patch in the v4.8 or the v4.9-rc1.
> 
> I think it slipped through the cracks as there were the only one in the
> fixes branches.
> 
> Do you think you could make them part of your next pull request for
> fixes for 4.9-rc2?

Indeed, I missed how this was still on the fixes branch during
the merge window. It is still on that branch (and nothing else
is so far), and it will be part of the next fixes pull request.

Thanks for the reminder.

	Arnd
