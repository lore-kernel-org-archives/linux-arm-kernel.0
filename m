From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 8 Sep 2016 19:46:34 +0800
Subject: [PATCH v4 1/4] arm64: arch_timer: Add device tree binding for
 A-008585 erratum
In-Reply-To: <e69db8b1-5fe2-ed0a-b073-de3efdd854d2@suse.com>
References: <1467877572-10817-1-git-send-email-oss@buserror.net>
 <e69db8b1-5fe2-ed0a-b073-de3efdd854d2@suse.com>
Message-ID: <57D14F9A.2050007@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping

On 2016/8/25 19:04, Matthias Brugger wrote:
> Hi all,
> 
> On 07/07/16 09:46, Scott Wood wrote:
>> This erratum describes a bug in logic outside the core, so MIDR can't be
>> used to identify its presence, and reading an SoC-specific revision
>> register from common arch timer code would be awkward.  So, describe it
>> in the device tree.
>>
>> Signed-off-by: Scott Wood <oss@buserror.net>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
> 
> As of today I wasn't able to find this series in linux-next. Was this series somehow forgotten? Scott maybe you can resend the patches adding the clocksource maintainer.
> 
> Regards,
> Matthias
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
