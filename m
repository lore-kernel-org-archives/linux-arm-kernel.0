From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 6 Jul 2018 18:09:17 +0100
Subject: [REGRESSION] arm32 Cubietruck defconfig does not boot anymore
 since 4.18-rc1
In-Reply-To: <20180706170400.GA4961@arm.com>
References: <1879608911.1296.1530896362007.JavaMail.zimbra@efficios.com>
 <20180706170400.GA4961@arm.com>
Message-ID: <436511d7-34f7-e980-2a99-c2b216c6669b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/18 18:04, Will Deacon wrote:
> Hi Mathieu,
> 
> On Fri, Jul 06, 2018 at 12:59:22PM -0400, Mathieu Desnoyers wrote:
>> The 4.18-rc3 arm32 kernel defconfig fails to boot on my Cubietruck.
>> This issue appeared with 4.18-rc1.
>>
>> It worked fine on 4.17.
>>
>> Any ideas ?
> 
> CC'ing linux-arm-kernel would be a good place to start :) [I've added it
> here, as well as Maxime and Marc].
> 
> With the right people on cc, I suspect this is a known issue and might
> even have a patch. (he says hopefully...)

I have had issues as well. With this patch[1] applied, my board works
well enough.

Thanks,

	M.

[1] https://lkml.org/lkml/2018/7/4/73
-- 
Jazz is not dead. It just smells funny...
