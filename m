From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed, 08 Sep 2010 20:15:00 -0700
Subject: [PATCH 09/24] msm: MSM8X60 RUMI3 board support
In-Reply-To: <20100902110850.GV26319@n2100.arm.linux.org.uk>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-10-git-send-email-johlstei@codeaurora.org>
	<20100902110850.GV26319@n2100.arm.linux.org.uk>
Message-ID: <4C885134.3070703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Aug 24, 2010 at 09:57:38PM -0700, Jeff Ohlstein wrote:
>   
>> +
>> +extern struct sys_timer msm_timer;
>> +void __iomem *gic_cpu_base_addr;
>>     
> Please move to a header file.
>   
I can move the extern to a header, not sure about the gic_cpu_base_addr. 
Seems like other machine types have it in C code. Even with a prototype 
in a header I need to define it somewhere.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
