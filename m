From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 06 Jul 2011 10:59:40 -0700
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace boot_params
In-Reply-To: <alpine.LFD.2.00.1107060845140.14596@xanadu.home>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<4E13E46D.3050205@codeaurora.org>
	<alpine.LFD.2.00.1107060845140.14596@xanadu.home>
Message-ID: <4E14A28C.9020408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2011 05:54 AM, Nicolas Pitre wrote:
> On Tue, 5 Jul 2011, Stephen Boyd wrote:
>
>>
>> Would it make sense to drop the atag_offset in most board files and
>> default it to 0x100 in the MACHINE_START macro itself? It's almost a
>> universal value and would cut down on hundreds of lines.
>
> Well, no more than 50 lines actually.
>
> And there are those cases where that value is not set to anything, and 
> therefore I'd prefer we don't start always assuming something at 0x*100 
> for them.  IOW, this is meant to be functionally transparent.

Fair enough. Probably too magical anyway.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
