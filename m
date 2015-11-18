From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Wed, 18 Nov 2015 21:38:48 +0800
Subject: [PATCH v3 01/62] Revert "xen/arm: vgic-v2: Drop cbase from
 arch_domain"
In-Reply-To: <564C7E38.8010507@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-2-git-send-email-shannon.zhao@linaro.org>
 <564B0F1E.9040804@citrix.com> <564B1E62.8080208@huawei.com>
 <564B3255.6040108@citrix.com> <564BE23C.6020808@huawei.com>
 <564C63E6.2080104@citrix.com> <564C786D.5050108@linaro.org>
 <564C7E38.8010507@citrix.com>
Message-ID: <564C7F68.9010009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/18 21:33, Julien Grall wrote:
> On 18/11/15 13:09, Shannon Zhao wrote:
>>> Note it's a mandatory to emulate the same version as the hardware for
>>> the virtual GIC.
>>>
>> So it doesn't support vGICv2 on GICv3 hardware for Xen?
>
> Sorry I forgot to say it was for DOM0. We support GICv2 on GICv3 only
> for guest.
>
Ok, I see. Thanks for your explanation.

-- 
Shannon
