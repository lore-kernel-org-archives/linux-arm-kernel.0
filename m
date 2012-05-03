From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 03 May 2012 17:59:54 +0100
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <20120503164501.GG897@n2100.arm.linux.org.uk>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org> <20120425185747.GC24211@n2100.arm.linux.org.uk>
 <4FA29E46.6040204@linaro.org> <20120503151253.GE897@n2100.arm.linux.org.uk>
 <4FA2A4A8.9010208@linaro.org> <20120503163008.GF897@n2100.arm.linux.org.uk>
 <4FA2B4A3.2040402@linaro.org> <20120503164501.GG897@n2100.arm.linux.org.uk>
Message-ID: <4FA2B98A.6060800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/12 17:45, Russell King - ARM Linux wrote:
> On Thu, May 03, 2012 at 05:38:59PM +0100, Lee Jones wrote:
>> Would you be kind enough to cast your eye over the documentation patch
>> as well please? I believe Chris is waiting on an Ack from you before he
>> will pull it.
>>
>> [PATCH 7/7] MMC: mmci: Add required documentation for Device Tree bindings
>
> I'm not sure I'm the right person for doing that because I've hardly
> touched DT stuff.
>
> Provided the properties are sanely named, and the common properties between
> drivers is already sensibly separated, then I don't see there's much to
> comment on.

That sounds fair.

> One thing that might help is if the format of these descriptions were
> changed so that there was one file per subsystem documenting the common
> options, rather than (eg) every MMC driver documentating the same base
> options time and time again.

I'm afraid that's not really for me to decide, however Grant is on CC. 
Perhaps that's a point he'd like to drive. If he's stopped reading this 
thread and fails to reply, I will endeavor to poke him about it while 
we're in Hong Kong.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
