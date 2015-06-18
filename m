From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 18 Jun 2015 20:20:31 +0100
Subject: [PATCH 13/13] KVM: arm64: enable ITS emulation as a virtual MSI
 controller
In-Reply-To: <01a401d0a9d7$e87997d0$b96cc770$@samsung.com>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <1432893209-27313-14-git-send-email-andre.przywara@arm.com>
 <558284B4.104@linaro.org> <5582D410.60708@arm.com>
 <01a401d0a9d7$e87997d0$b96cc770$@samsung.com>
Message-ID: <558319FF.4090809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2015 04:03 PM, Pavel Fedin wrote:
>  Hello!
> 
>> But that fails compilation on ARM (which uses this file as well),
>> because we have a dummy fail function in the header if
>> CONFIG_HAVE_KVM_MSI is not defined.
> 
>  May be then remove that fail function too? Too many #ifdef's are not good...

Yes, that seems to work - now. I think I had more code in there before
that prevented exposure without #ifdef guarding.

Cheers,
Andre.

> 
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
> 
> 
