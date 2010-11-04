From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Thu, 4 Nov 2010 21:23:11 +0900
Subject: [PATCH] arm: Fix HAVE_S3C2410_WATCHDOG warnings
In-Reply-To: <4CD282A7.9080204@embtoolkit.org>
References: <20101104081633.GA27129@july>
	<4CD282A7.9080204@embtoolkit.org>
Message-ID: <AANLkTim_YDa9k2LiiNTswhynGQCO=V_kEv1CpOMEZgN0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It's another patch. Can you send the patch?

Thank you,
Kyungmin Park
On Nov 4, 2010 6:58 PM, "Abdoulaye Walsimou GAYE" <awg@embtoolkit.org>
wrote:
> On 11/04/2010 09:16 AM, Kyungmin Park wrote:
>> Fix build warnings
>> warning: (ARCH_S3C64XX && <choice> && WATCHDOG || ARCH_S5P64X0 &&
<choice> && WATCHDOG || ARCH_S5P6442 && <choice> && WATCHDOG || ARCH_S5PC100
&& <choice> || ARCH_S5PV210 && <choice> || ARCH_S5PV310 && <choice> ||
MACH_SMDK6410 && ARCH_S3C64XX) selects HAVE_S3C2410_WATCHDOG which has unmet
direct dependencies (WATCHDOG)
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>
> Kyungmin Park,
> The same warning appears when I2C is not selected.
>
> Best regards,
> AWG
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101104/15653c43/attachment-0001.html>
