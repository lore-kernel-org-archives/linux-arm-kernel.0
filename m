From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Feb 2016 09:51:32 +0000
Subject: [PATCH] ARM: dts: rockchip: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <48510660.EJbbczq5fX@phil>
References: <1454968512-11956-1-git-send-email-sudeep.holla@arm.com>
 <48510660.EJbbczq5fX@phil>
Message-ID: <56BB0824.2030900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/02/16 23:32, Heiko Stuebner wrote:
> Hi Sudeep,
>
> Am Montag, 8. Februar 2016, 21:55:12 schrieb Sudeep Holla:

[..]

>> Hi Heiko,
>>
>> You can reviewed this, however there are couple of ARM64 dts additions.
>> Also most of the other platform/SoC maintainers preferred to take it via
>> their tree and few of these got missed during v4.5 merge window.
>> Can you take it via your tree for v4.6 ?
>
> I've split the patch in two, as the 32 and 64 bit devicetree parts go
> through separate branches and applied both to their respective branches for
> v4.6

Thanks for splitting up the patch yourself.

-- 
Regards,
Sudeep
