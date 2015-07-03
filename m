From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 03 Jul 2015 17:42:08 +0200
Subject: [PATCH 1/7] KVM: api: add kvm_irq_routing_extended_msi
In-Reply-To: <018401d0b5a5$10576a60$31063f20$@samsung.com>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-2-git-send-email-eric.auger@linaro.org>
 <011f01d0b498$6a17aeb0$3e470c10$@samsung.com> <55954F6E.5030008@linaro.org>
 <55955542.6000809@arm.com> <55955728.3080506@linaro.org>
 <02eb01d0b4dd$50b25160$f216f420$@samsung.com> <55955B98.1000504@linaro.org>
 <018401d0b5a5$10576a60$31063f20$@samsung.com>
Message-ID: <5596AD50.70103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2015 05:29 PM, Pavel Fedin wrote:
>  Hi!
> 
>> OK so both of you say the same thing. Will respin accordingly
> 
>  You may also want to add this:
> Tested-by: Pavel Fedin <p.fedin@samsung.com>

Thanks Pavel for the intent. However since I am going to change the uapi
and correct the bug you spotted out, this will need to be tested again.
T-b is applied when the code is stable and bug-free I think ;-)

Best Regards

Eric
> 
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
> 
