From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Nov 2012 16:16:38 +0000
Subject: [PATCH 1/2] Boottime: A tool for automatic measurement of
 kernel/bootloader boot time
In-Reply-To: <20121115112543.GC21682@gmail.com>
References: <1352973847-21605-1-git-send-email-lee.jones@linaro.org>
 <1352973847-21605-2-git-send-email-lee.jones@linaro.org>
 <CAH9JG2UX0Wyr-QKw3=tbUXeuEhHe04_cFkkAp6bB2Rr-x7ViHQ@mail.gmail.com>
 <20121115112543.GC21682@gmail.com>
Message-ID: <20121120161638.GD28265@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Okay, so I'm going through the motions of upstreaming this magic
now. Please see the link below for reference:

http://marc.info/?l=u-boot&m=135342273317337&w=2

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
