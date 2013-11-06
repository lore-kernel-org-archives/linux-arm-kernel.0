From: liuj97@gmail.com (Jiang Liu)
Date: Thu, 07 Nov 2013 00:32:54 +0800
Subject: [PATCH v5 5/7] arm64, jump label: detect %c support for ARM64
In-Reply-To: <20131030004927.GD25346@mudshark.cambridge.arm.com>
References: <1382109602-27432-1-git-send-email-liuj97@gmail.com>
 <1382109602-27432-6-git-send-email-liuj97@gmail.com>
 <20131030004927.GD25346@mudshark.cambridge.arm.com>
Message-ID: <527A6F36.7030300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2013 08:49 AM, Will Deacon wrote:
> On Fri, Oct 18, 2013 at 04:19:59PM +0100, Jiang Liu wrote:
>> From: Jiang Liu <jiang.liu@huawei.com>
>>
>> As commit a9468f30b5eac6 "ARM: 7333/2: jump label: detect %c
>> support for ARM", this patch detects the same thing for ARM64
>> because some ARM64 GCC versions have the same issue.
>>
>> Some versions of ARM64 GCC which do support asm goto, do not
>> support the %c specifier. Since we need the %c to support jump
>> labels on ARM64, detect that too in the asm goto detection script
>> to avoid build errors with these versions.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> The toolchain is being fixed upstream for this, but we should have the check
> for older versions.
> 
> Will
> 
Thanks for review!
