From: dingtianhong@huawei.com (Dingtianhong)
Date: Tue, 22 Sep 2015 18:08:29 +0000
Subject: =?gb2312?B?tPC4tDogW1JGQyBQQVRDSCB2MiAwLzddIFBzZXVkby1OTUkgZm9yIGFybTY0?=
 =?gb2312?B?IHVzaW5nIElDQ19QTVJfRUwxIChHSUN2Myk=?=
In-Reply-To: <55FBF42B.2090806@linaro.org>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
 <32CDD1A8-EF10-4F6B-86B6-64981874361A@jonmasters.org>,
 <55FBF42B.2090806@linaro.org>
Message-ID: <DCFA7C6322CB9F469EBAE61213CF16B04C133777@SZXEMA512-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



________________________________________
???: linux-arm-kernel [linux-arm-kernel-bounces at lists.infradead.org] ?? Daniel Thompson [daniel.thompson at linaro.org]
????: 2015?9?18? 19:23
???: Jon Masters
??: linaro-kernel at lists.linaro.org; patches at linaro.org; Marc Zyngier; Catalin Marinas; linux-kernel at vger.kernel.org; Andrew Thoelke; Dave Martin; linux-arm-kernel at lists.infradead.org
??: Re: [RFC PATCH v2 0/7] Pseudo-NMI for arm64 using ICC_PMR_EL1 (GICv3)

On 18/09/15 06:11, Jon Masters wrote:
>> On Sep 14, 2015, at 06:26, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>> This patchset provides a pseudo-NMI for arm64 kernels by reimplementing
>> the irqflags macros to modify the GIC PMR (the priority mask register is
>> accessible as a system register on GICv3 and later) rather than the
>> PSR. The patchset includes an implementation of
>> arch_trigger_all_cpu_backtrace() for arm64 allowing the new code to be
>> exercised.
>
> I think there is a need to connect a few dots on this next week
> during Connect. Some other conversations have discussed alternative
> implementations elsewhere. I will assist.

Fine by me.

I'd be very happy to talk about alternative approaches. In the past I've
had long conversations about trapping to ARM TF as a means to simulate
NMI. I haven't written any code to move in this direction but I still
think of it as being the future-areas-of-interest pile.

That said, whenever I search for (what I think are) sensible keywords
for this subject I generally only find my own work! I may be selecting a
rather blinkered set of keywords when I search but nevertheless it does
mean I will probably have to rely on you to make introductions!


Hi Daniel:

I have checked that trapping to ARM TF could work well for aarch64 as NMI, and maybe we could discussion about it. :)

Ding


Daniel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
