From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 May 2014 07:06:10 +0900
Subject: [PATCH v2] cpufreq: exynos: Fix driver compilation with
 ARCH_MULTIPLATFORM
In-Reply-To: <CAKohpo=b=Jm4vZfgS2YPA740QfvktgVExXXzOdSUmQjGWhzrhg@mail.gmail.com>
References: <1400670752-673-1-git-send-email-t.figa@samsung.com>	<1400858533-4327-1-git-send-email-t.figa@samsung.com>	<53826377.8060709@samsung.com>
 <CAKohpo=b=Jm4vZfgS2YPA740QfvktgVExXXzOdSUmQjGWhzrhg@mail.gmail.com>
Message-ID: <5383BAD2.6020406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/14 14:40, Viresh Kumar wrote:
> On 26 May 2014 03:11, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>> I'm not sure Thomas' v5 cpufreq-cpu0 driver can be upstreamed for 3.16
>> because of dependency with others, some of them got ack though...
>>
>> * "PM / OPP: move cpufreq specific helpers out of OPP layer"
>> - https://www.mail-archive.com/linux-omap at vger.kernel.org/msg104610.html
>
> This is already lying in Rafael's tree.
>
Good.

>> * "cpufreq: opp: Add device tree based lookup of boost mode frequency"
>> - http://www.spinics.net/lists/arm-kernel/msg334336.html
>>
Probably need more time?

>> So firstly, I've queued this instead with exynos-multiplatform series...
>>
>> How do you think?
>
> Looks fine to me. Thanks.

OK, I applied with your ack.

Thanks,
- Kukjin
