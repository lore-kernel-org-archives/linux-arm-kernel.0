From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 07 Jul 2015 09:43:37 +0200
Subject: [PATCH 1/7] KVM: api: add kvm_irq_routing_extended_msi
In-Reply-To: <014d01d0b885$d3228380$79678a80$@samsung.com>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-2-git-send-email-eric.auger@linaro.org>
 <011f01d0b498$6a17aeb0$3e470c10$@samsung.com> <5596503E.6040902@arm.com>
 <00fd01d0b7b6$f6cf3550$e46d9ff0$@samsung.com> <559A3C9C.6050302@arm.com>
 <20150706093026.GA11590@cbox> <559A52E6.5050402@arm.com>
 <20150706103755.GC11590@cbox> <559A6164.1000401@redhat.com>
 <559A6527.1040107@arm.com> <559A6BBC.2040901@redhat.com>
 <024301d0b7f0$2b13b410$813b1c30$@samsung.com> <559A9854.2090607@linaro.org>
 <559AA449.80705@arm.com> <014d01d0b885$d3228380$79678a80$@samsung.com>
Message-ID: <559B8329.9070105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,
On 07/07/2015 09:23 AM, Pavel Fedin wrote:
>  Hi!
> 
>> I guess not. But I prefer the new type anyway, as it also has a known
>> error path for older kernels.
> 
>  flags != 0 has known error path too, and it's absolutely the same.
>  Sorry, read this after writing my previous reply, so this is a short addendum.
> 
>  I see lots of people agreed on a new type. If my argument about reusing existing definitions is not
> enough, you can ignore it. Three people beat one definitely. :)
OK. let's move forward and use this new type. I will repost soon so
everyone can re-check the fit at kvmtool/qemu.

Thanks

Eric
>  And yes, since we are talking about it, actually KVM_MSI_VALID_DEVID flag is not yet a part of
> mainline, so it's not set in stone. Then, perhaps you could throw it away completely and invent
> KVM_SIGNAL_EXT_MSI ioctl for sending MSIs with device ID. This would also be consistent IMO.
> 
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
> 
> 
