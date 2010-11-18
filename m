From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Wed, 17 Nov 2010 19:12:50 -0800
Subject: [PATCH 5/9] ARM: mmp: select CPU_PJ4
In-Reply-To: <4CE3D514.8080404@ru.mvista.com>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-4-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
	<4CE3D514.8080404@ru.mvista.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05986C79B0@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Sergei Shtylyov [mailto:sshtylyov at mvista.com]
>Sent: 2010?11?17? 9:14 PM
>To: Haojian Zhuang
>Cc: linux-arm-kernel at lists.infradead.org; Eric Miao
>Subject: Re: [PATCH 5/9] ARM: mmp: select CPU_PJ4
>
>Hello.
>
>On 17-11-2010 14:03, Haojian Zhuang wrote:
>
>> Since CPU_PJ4 is shared between PXA95x and MMP2, select CPU_PJ4 in MMP2
>> configuration.
>
>> Signed-off-by: Haojian Zhuang<haojian.zhuang@marvell.com>
>> Cc: Eric Miao<eric.y.miao@gmail.com>
>[...]
>
>> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
>> index 0711d3b..ab39b1e 100644
>> --- a/arch/arm/mach-mmp/Kconfig
>> +++ b/arch/arm/mach-mmp/Kconfig
>> @@ -39,6 +39,7 @@ config MACH_TTC_DKB
>>
>>   config MACH_FLINT
>>   	bool "Marvell's Flint Development Platform"
>> +	depends on !(CPU_MOHAWK)
>
>    () not needed.
>

Thanks. Now it's fixed in attachment.

Best Regards
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-ARM-mmp-select-CPU_PJ4.patch
Type: application/octet-stream
Size: 1759 bytes
Desc: 0005-ARM-mmp-select-CPU_PJ4.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101117/56eb32e0/attachment.obj>
