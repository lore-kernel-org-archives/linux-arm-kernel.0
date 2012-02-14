From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 21:09:30 -0600
Subject: [PATCH 00/15] mach/io.h cleanup and removal
In-Reply-To: <20120213222220.GI1426@atomide.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <20120213222220.GI1426@atomide.com>
Message-ID: <4F39D06A.3060104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2012 04:22 PM, Tony Lindgren wrote:
> * Rob Herring <robherring2@gmail.com> [120213 13:12]:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This series cleans-up mach/io.h and removes it for most platforms that have
>> the same definitions of __io() and __mem_pci(). This mainly leaves platforms
>> with PCI that need an io.h. Most of those can be converted once we have a
>> fixed IO space mapping. OMAP io.h also remains as moving all the extra io.h
>> stuff leaves it quite broken, so I'm leaving it to the OMAP folks to convert.
> 
> I'll do some patches to use iomap.h on omaps. Are you planning to queue
> these for v3.4 merge window?
> 
> If these are for v3.5 merge window, then I'll do a cleanup series that
> just leaves a minimal io.h for omaps that's easy to convert. If you're
> still planning these for v3.4 merge window, I'll rebase on your series.

I would like to get it in for 3.4, but it really depends on Russell. If
not, I'll at least get the header clean-ups in for 3.4.

Rob
