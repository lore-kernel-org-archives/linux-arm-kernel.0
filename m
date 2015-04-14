From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 14 Apr 2015 09:44:11 -0500
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <245B9FDD-E1B5-41E4-9F24-4D5BB86C450E@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <493B15F8-0EBE-4633-9604-671EF403F36E@codeaurora.org>
 <20150410161052.GF6854@e104818-lin.cambridge.arm.com>
 <FDC755A7-ACCF-4222-8730-782EEC632159@codeaurora.org>
 <20150413094117.GA2745@e104818-lin.cambridge.arm.com>
 <245B9FDD-E1B5-41E4-9F24-4D5BB86C450E@codeaurora.org>
Message-ID: <97B1A2D4-6F6B-433B-83E6-9C8A95D1BFC6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Apr 14, 2015, at 9:21 AM, Kumar Gala <galak@codeaurora.org> wrote:
> 
>>>> 
>>>> So please come up with proper technical arguments rather than the kernel
>>>> should take whatever SoC vendors dreamt of.
>>> 
>>> There is no technical argument to be made.  This is about the
>>> community and you as maintainer wanting to accept code that complies
>>> to your decision or not.
>> 
>> If you are not willing to make technical arguments, I don't have to
>> provide any further reasons in this thread. It's your choice. In the
>> meantime, the short answer is NAK.

I assume you would than NAK someone trying to get support for their Nexus 9 Tablet using a Tegra K1.  It appears the shipping code for that device didn?t use PSCI (again guessing because it wasn?t available at the time).

https://android.googlesource.com/kernel/tegra/+/android-tegra-flounder-3.10-lollipop-release/arch/arm64/mach-tegra/platsmp.c

If so, I find this counter to the Linux kernel communities normal desire to support the most hardware platforms.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
