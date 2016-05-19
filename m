From: saberlily.xia@hisilicon.com (Xiaqing (A))
Date: Thu, 19 May 2016 19:06:40 +0800
Subject: [PATCH] arm64: cpuinfo: add AArch64 & elf platform for app
 compatibility
In-Reply-To: <20160519104925.GL22378@e104818-lin.cambridge.arm.com>
References: <1463625873-60016-1-git-send-email-saberlily.xia@hisilicon.com>
 <20160519104925.GL22378@e104818-lin.cambridge.arm.com>
Message-ID: <573D9E40.4000705@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016/5/19 18:49, Catalin Marinas ??:
> On Thu, May 19, 2016 at 10:44:33AM +0800, x00195127 wrote:
>> we find that some apps will read cpuinfo when start up,
>> they need the string  as follows:
>> "Processor       : AArch64 Processor rev 0 (aarch64)"
>>
>> Then thay could load the corresponding libs. But now
>> arm64 platform's cpuinfo don't has this now, so
>> we need add this.
>
> I have the same question as Martinez: what are those apps? If they are
> 64-bit apps, they can always assume AArch64 processor.
>

Those are 32-bit apps, and those apps are very popular in our country.
