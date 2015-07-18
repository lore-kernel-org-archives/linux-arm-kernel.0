From: eric.auger@linaro.org (Eric Auger)
Date: Sat, 18 Jul 2015 20:39:25 +0200
Subject: [PATCH v2 3/7] KVM: irqchip: convey devid to kvm_set_msi
In-Reply-To: <029401d0c07a$55a3ddd0$00eb9970$@samsung.com>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
 <1436430137-24205-4-git-send-email-eric.auger@linaro.org>
 <01d401d0c062$086c2ee0$19448ca0$@samsung.com> <55A8D44A.3030105@redhat.com>
 <029401d0c07a$55a3ddd0$00eb9970$@samsung.com>
Message-ID: <55AA9D5D.7010607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2015 12:21 PM, Pavel Fedin wrote:
>  Hello!
> 
>>>>> +	} else if (!msi->flags)
>>>>> +		return -EINVAL;
>>>  Did you mean "if (msg->flags)" here (inverted condition)?
Yes thanks for spotting this.

Thanks

Eric
>>
>> Indeed, and also you need { } around the return for the QEMU coding
>> standard.
> 
>  It's kernel and not qemu :)
> 
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
> 
