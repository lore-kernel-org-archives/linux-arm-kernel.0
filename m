From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 8 Mar 2013 14:59:27 -0300
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308172950.GC4094@obsidianresearch.com>
References: <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307222004.GA2450@localhost>
 <20130307230516.GA28975@obsidianresearch.com>
 <20130308091052.18612729@skate>
 <20130308172950.GC4094@obsidianresearch.com>
Message-ID: <20130308175926.GC8693@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Fri, Mar 08, 2013 at 10:29:50AM -0700, Jason Gunthorpe wrote:
> 
> I looked through Ezequiel's patch and saw a driver that provided those
> properties and no user of them at all. Are the patches incomplete? Is
> there some plan to use these values in the future?
> 

Leaving aside the review comments that still I haven't addressed yet,
the patchset is complete.

The timings parameters were not set in device tree files,
not because I expected the bootloader to set them, but instead because
SoC default values worked fine for the NOR devices I tested.

If this is suboptimal, I can fix the device tree files in v2
to set proper timings parameter values.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
