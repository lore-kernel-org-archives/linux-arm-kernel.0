From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 13 Jul 2015 16:24:23 +0200
Subject: Extensions for KVM MSI related ioctls
In-Reply-To: <03b901d0bd70$6c2f4b50$448de1f0$@samsung.com>
References: <55A39231.4050904@arm.com> <55A3B090.6090002@redhat.com>
 <03b901d0bd70$6c2f4b50$448de1f0$@samsung.com>
Message-ID: <55A3CA17.1010500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2015 03:32 PM, Pavel Fedin wrote:
>  Hello!
> 
>> I think I prefer the flag.  Offhand it sounds easier to add support for
>> it to non-ARM architectures, compared to KVM_IRQ_ROUTING_EXTENDED_MSI.
> 
>  Actually i also voted for flag, because it is already introduced in (2), and i'm not a fan of
> adding new definitions where we can reuse existing ones. IMHO using flag would make an API more
> consistent.

OK I will respin with user space flag.

Andre, what about the kernel routing entry struct. You wanted me to get
rid of  KVM_IRQ_ROUTING_EXTENDED_MSI there too. Will you be able to
manage a usespace wrong setting if the type is not set?

Best Regards

Eric
> 
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
> 
> 
