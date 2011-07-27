From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 27 Jul 2011 11:23:31 -0700
Subject: [PATCHv3 2/2] ARM: P2V: Remove ARM_PATCH_PHYS_VIRT_16BIT
In-Reply-To: <20110727181000.GA10758@huya.qualcomm.com>
References: <1311733255-25207-1-git-send-email-sboyd@codeaurora.org>
	<1311733255-25207-2-git-send-email-sboyd@codeaurora.org>
	<20110727181000.GA10758@huya.qualcomm.com>
Message-ID: <4E3057A3.80509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2011 11:10 AM, David Brown wrote:
> On Tue, Jul 26, 2011 at 07:20:55PM -0700, Stephen Boyd wrote:
>> From: Nicolas Pitre <nicolas.pitre@linaro.org>
>>
>> Now that MSM targets no longer need the 16-bit offsets for P2V, this
>> code can be removed.
> There's still a reference to CONFIG_ARM_PATCH_PHYS_VIRT_16BIT in
> arch/arm/include/asm/modules.h that should probably be removed as
> well.
>
>

Ah ok. I'll fix that up too. V3 shortly.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
