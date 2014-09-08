From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 08 Sep 2014 13:55:29 +0200
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <20140908112112.GK26030@arm.com>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
 <20140908112112.GK26030@arm.com>
Message-ID: <540D9931.6050603@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

On 09/08/2014 01:21 PM, Will Deacon wrote:
> On Sun, Sep 07, 2014 at 05:19:03PM +0100, Tomasz Figa wrote:
>> At least for next 3.17-rc I'd suggest fixing this up in respective clock
>> driver and dropping the hack only after Exynos DRM patches are merged
>> and confirmed working.
> 
> Whilst I'm sympathetic to people working to enable DRM, I think this is
> the right solution to the problem. The transition from simplefb to DRM
> shouldn't break display for a bunch of kernel revisions whilst the code is
> in flux.
> 

Agreed, I'm preparing a patch-set to prevent the kernel to disable both the
clocks and regulators needed for the display, I'll try to post it today or
tomorrow at worst.

> Will
> 

Best regards,
Javier
