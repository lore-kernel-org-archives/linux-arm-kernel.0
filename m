From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 23 Jul 2018 13:48:59 +0200
Subject: Subject: [PATCH 00/22] gpio: xilinx: update driver to match
 official xilinx version
In-Reply-To: <CACRpkdan_Fc8E2o69_48OZU-N_4HUBh2uY77Se3qTVvRSny3bA@mail.gmail.com>
References: <5D23E7CAADD3BE4A97642792FFC691C561C7A3D7@MBX215.d.ethz.ch>
 <CACRpkdan_Fc8E2o69_48OZU-N_4HUBh2uY77Se3qTVvRSny3bA@mail.gmail.com>
Message-ID: <725e0413-7293-5535-73b9-78c28e56e321@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.7.2018 21:24, Linus Walleij wrote:
> On Sat, Jul 21, 2018 at 4:14 PM Hedges Alexander
> <ahedges@student.ethz.ch> wrote:
> 
> An overarching question:
> 
> the whole patch set contains things like this:
> 
>> +#ifdef CONFIG_OF
> (...)
>> +#else
> (...)
>> +#endif
> 
> But arch/arm/mach-zynq and the Aarch64 counterpart are
> OF-only.
> 
> I.e. these adaptions must have been made for some Xilinx
> platform support codebase that is not upstream, and which does
> not use device tree.

I was used 10+ years ago when CONFIG_OF doesn't exist.
All these platforms have been moved to OF long time ago too.
I don't think there is any reason to keep any support for !OF case.

Thanks,
Michal
