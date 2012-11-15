From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 12:25:30 +0000
Subject: [PATCH 1/2] Boottime: A tool for automatic measurement of
 kernel/bootloader boot time
In-Reply-To: <20121115112543.GC21682@gmail.com>
References: <1352973847-21605-1-git-send-email-lee.jones@linaro.org>
 <CAH9JG2UX0Wyr-QKw3=tbUXeuEhHe04_cFkkAp6bB2Rr-x7ViHQ@mail.gmail.com>
 <20121115112543.GC21682@gmail.com>
Message-ID: <201211151225.31066.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Lee Jones wrote:
> 
> > > +/* for automatic boot timing testcases */
> > > +#define ATAG_BOOTTIME  0x41000403
> > Where can I refer this ATAG usage? can you point out the reference URL
> > or patches?
> 
> I assumed this would be in Mainline u-boot, but apparently not.
> On closer inspection of the internal ST-Ericsson u-boot, this
> functionality appears to be provided by patches which currently
> exist as delta. So in essence, the bootloader you use will have
> to be patched in a similar way for you to retrieve information
> surrounding bootloader boot times.
> 
> And there was me thinking it was magic. ;)
> 

And since we're moving away from ATAG on ux500 towards DT, it won't
even work in the future. How essential is this part for the operation
of your code?

	Arnd
