From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 14 Jun 2016 17:31:06 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <1465918285.2840.41.camel@linaro.org>
References: <20150316195255.GM8656@n2100.arm.linux.org.uk>
 <550818A6.9020205@arm.com> <20150317153657.GY8656@n2100.arm.linux.org.uk>
 <55084D99.7050004@arm.com> <20150317161748.GZ8656@n2100.arm.linux.org.uk>
 <20150330140333.GJ24899@n2100.arm.linux.org.uk> <55196228.5050805@arm.com>
 <20150330150552.GK24899@n2100.arm.linux.org.uk> <55196E31.80803@arm.com>
 <551AD902.9090401@arm.com> <20150402141336.GI24899@n2100.arm.linux.org.uk>
 <551D7EAB.1000200@arm.com> <1465918285.2840.41.camel@linaro.org>
Message-ID: <5760314A.4060509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tixy,

On 14/06/16 16:31, Jon Medhurst (Tixy) wrote:
> Hi Sudeep
>
> Over the past several days I think I've been unknowingly reproducing
> many of the steps in this old discussion thread [1] about A9 Versatile
> Express boot failures. It's only when I found myself looking at the L2
> cache timings that I got a vague recollection and dug out this old
> thread again. Was there any resolution to the issue? As far as I can
> work out, the A9x4 CoreTile stopped working around Linux 3.18 (the
> problem isn't 100% reproducible so it's difficult to tell).
>
> Using "arm,tag-latency = <2 2 1>" as Russell seemed to indicate [2]
> fixed things for him, also works for me. So should we update mainline
> device-tree with that?
>

That's fine by me.

> Alternatively, we could assume nobody cares about A9 as presumably Linux
> has been unbootable for a year without anyone raising the issue. (The
> only reason I'm looking at it is I may be making U-Boot changes for
> vexpress and I wanted to test them).
>

I admit I just do a boot test every release and I seem to have flashed
the DT so failed to notice any issue. That's my fault.

> But if we are going to just ignore things, I think it would be good to
> delete the A9 dts, or the L2 cache entry, so other people in the future
> don't waste days trying to track down the problem.
>

I am fine either way, if people still use it as reference, we can retain it.

-- 
Regards,
Sudeep
