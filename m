From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Fri, 17 Feb 2017 13:20:55 +0000
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
In-Reply-To: <2cecfc48-576f-3888-08aa-1fe2edc3c752@math.uni-bielefeld.de>
References: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
 <20170216184524.cxcy2ux37yrwutla@lukather>
 <2cecfc48-576f-3888-08aa-1fe2edc3c752@math.uni-bielefeld.de>
Message-ID: <CACvgo51VRwMneHuS2jrM9ug8OEBsh5AD0ncpYfAZkGBFGKYMsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2017 at 12:45, Tobias Jakobi
<tjakobi@math.uni-bielefeld.de> wrote:
> Hello Maxime,
>
> Maxime Ripard wrote:
>> Hi,
>>
>> On Thu, Feb 16, 2017 at 01:43:06PM +0100, Tobias Jakobi wrote:
>>> I was wondering about the following. Wasn't there some strict
>>> requirement about code going upstream, which also included that there
>>> was a full open-source driver stack for it?
>>>
>>> I don't see how this is the case for Mali, neither in the kernel, nor in
>>> userspace. I'm aware that the Mali kernel driver is open-source. But it
>>> is not upstream, maintained out of tree, and won't land upstream in its
>>> current form (no resemblence to a DRM driver at all). And let's not talk
>>> about the userspace part.
>>>
>>> So, why should this be here?
>>
>> The device tree is a representation of the hardware itself. The state
>> of the driver support doesn't change the hardware you're running on,
>> just like your BIOS/UEFI on x86 won't change the device it reports to
>> Linux based on whether it has a driver for it.
> Like Emil already said, the new bindings and the DT entries are solely
> introduced to support a proprietary out-of-tree module.
>
> The current workflow when introducing new DT entries is the following:
> - upstream a driver that uses the entries
> - THEN add the new entries
>
That's the ideal route that I was thinking of.

At the same time, if prominent DRM people believe that we can/should
turn a blind eye, so be it.
I'm not trying to make Maxime's life hard, but point out that things
feel iffy IMHO.

Thanks
Emil
