From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 21:20:14 -0600
Subject: [PATCH 00/15] mach/io.h cleanup and removal
In-Reply-To: <20120213234109.GJ1426@atomide.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <20120213234109.GJ1426@atomide.com>
Message-ID: <4F39D2EE.80806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2012 05:41 PM, Tony Lindgren wrote:
> * Rob Herring <robherring2@gmail.com> [120213 13:12]:
>>  arch/arm/mach-at91/include/mach/at91_io.h         |   44 +++++++++++++++++
>>  arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |    2 +
>>  arch/arm/mach-at91/include/mach/at91sam9_sdramc.h |    2 +
> ...
>>  arch/arm/mach-msm/include/mach/msm_iomap-7x00.h   |    6 ++
>>  arch/arm/mach-msm/include/mach/msm_iomap-7x30.h   |    4 ++
>>  arch/arm/mach-msm/include/mach/msm_iomap-8960.h   |    4 ++
>>  arch/arm/mach-msm/include/mach/msm_iomap-8x50.h   |    4 ++
>>  arch/arm/mach-msm/include/mach/msm_iomap-8x60.h   |    4 ++
> ...
> 
> Considering the naming above..
> 
>>  arch/arm/mach-tegra/include/mach/iomap.h          |   48 ++++++++++++++++++
> 
> ..should this be called tegra-iomap.h instead?

Probably, but it's not a new header. Fixing include paths or names is a
separate problem when we start having multiple mach include directories.
Perhaps we can get them removed altogether before we have to start
renaming. Much of it is device addresses that will go in dts files.

Rob
