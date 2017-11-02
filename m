From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Nov 2017 13:47:37 +0000
Subject: [PATCH] ARM: NOMMU: work around maybe-uninitialized warning
In-Reply-To: <fa406984-11dc-a6d9-b181-f0287afd746a@arm.com>
References: <20171102092155.737712-1-arnd@arndb.de>
 <681a1757-ddbe-c9a7-6945-fa72600cf172@arm.com>
 <20171102130734.GZ9463@n2100.armlinux.org.uk>
 <fa406984-11dc-a6d9-b181-f0287afd746a@arm.com>
Message-ID: <20171102134737.GA9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 01:11:23PM +0000, Vladimir Murzin wrote:
> On 02/11/17 13:07, Russell King - ARM Linux wrote:
> > I'd prefer not to at this stage.  Same things that apply that I said
> > in the "ARM: early_printk: use printascii() rather than printch()"
> > thread - I need to ensure that what I have is stable before 4.14 is
> > released, so I'm not accepting anything further unless it is _really_
> > urgent.
> 
> Yes, I saw that thread, it is why that "not sure" thing.
> 
> > 
> > This isn't urgent.
> > 
> 
> Should I resubmit after -rc1 or you'll apply it directly from patch tracker?

If you put it in the patch tracker now, I'll apply it when appropriate.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
