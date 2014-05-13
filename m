From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 May 2014 11:30:06 -0400
Subject: [PATCHv2 1/4] of: make of_update_property() usable earlier in
 the boot process
In-Reply-To: <20140513163026.18a0fa61@free-electrons.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqLNnLjeo2tM=z5bcn4DJD_5-uFRGkk6wAWnvGZyo9Y7pg@mail.gmail.com>
 <20140513163026.18a0fa61@free-electrons.com>
Message-ID: <20140513153006.GC27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 04:30:26PM +0200, Thomas Petazzoni wrote:
> On Tue, 13 May 2014 09:00:02 -0500, Rob Herring wrote:
...
> > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > Fixes: 75b57ecf9d1d1e17d099ab13b8f48e6e038676be ('of: Make device nodes kobjects so they show up in sysfs')
> > 
> > Humm, I didn't know about this new tag. This doesn't quite match what
> > SubmittingPatches says. It should be 12 digits of commit hash and
> > double quotes around the summary.
> 
> Well, I guess it's a per-maintainer choice:
> 
> git log | grep "^Fixes:"
> 
>     Fixes: 54fe26a900bc528f3df1e4235cb6b9ca5c6d4dc2 ('ARM: mvebu: Add thermal quirk for the Armada 375 DB board')

Well, just because the maintainer is an idiot and didn't catch it isn't
an excuse to continue the behavior. ;-)

>     Fixes: 54397d85349f ("ARM: kirkwood: Relocate PCIe device tree nodes")
>     Fixes: a7d4f81821f7 ('ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board')
>     Fixes: b484ff42df47 ('ARM: mvebu: Add support for NOR flash device on Armada XP-DB board')
>     Fixes: c971ff185f64 ("leds: leds-pwm: Defer led_pwm_set() if PWM can sleep")
>     Fixes: abccd00f8af2 ('btrfs: Fix 32/64-bit problem with BTRFS_SET_RECEIVED_SUBVOL ioctl')
>     Fixes: ee1e0994ab1bd (regulator: s5m8767: Use GPIO for controlling Buck9/eMMC)
>     Fixes: 652ed95d5fa6 (cpufreq: introduce cpufreq_generic_get() routine)
> 
> Somewhat inconsistent :-)

Yeah, I can go either way on the single quotes/double quotes.  The
12-character hash definitely increases readability, though.

thx,

Jason.
