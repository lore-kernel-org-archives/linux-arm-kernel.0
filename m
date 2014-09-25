From: isimatu.yasuaki@jp.fujitsu.com (Yasuaki Ishimatsu)
Date: Thu, 25 Sep 2014 17:15:55 +0900
Subject: [RFC Part2 v1 00/21] Enable hierarchy irqdomian on x86 platforms
In-Reply-To: <alpine.DEB.2.10.1409242122380.4604@nanos>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>
 <542279D0.1040603@jp.fujitsu.com> <alpine.DEB.2.10.1409242122380.4604@nanos>
Message-ID: <5423CF3B.4050107@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/09/25 4:25), Thomas Gleixner wrote:
> On Wed, 24 Sep 2014, Yasuaki Ishimatsu wrote:
>> I cannot imagine why the feature makes x86 irq architecture much more clear
>> and more easy to maintain in this description. Of course, I have read the
>> following threads:
>>
>> https://lkml.org/lkml/2014/9/11/101
>

> Here is the long version of the idea:
>
>       https://lkml.org/lkml/2014/8/26/707

This is very helpful for the understanding of this feature.

Thanks,
Yasuaki Ishimatsu

>
> Short version is:
>
> Separate the irq handling entities in a clear layered way instead of
> having vector/[io]apic specific knowledge/data in places like msi,
> remap etc.
>
> Thanks,
>
> 	tglx
>
