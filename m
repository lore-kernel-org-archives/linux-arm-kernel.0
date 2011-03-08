From: mnalajal@codeaurora.org (Murali Nalajala)
Date: Tue, 08 Mar 2011 10:41:03 -0700
Subject: [PATCH V2 1/2] mtd: nand: Allow NAND chip ids to be included
	standalone.
In-Reply-To: <1299570622.2754.4.camel@localhost>
References: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>
	<1299570622.2754.4.camel@localhost>
Message-ID: <4D766A2F.9080001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/8/2011 12:50 AM, Artem Bityutskiy wrote:
> On Tue, 2011-03-08 at 05:38 +0530, Murali Nalajala wrote:
>> Lets non-standard NAND drivers take advantage of known NAND
>> chip information.
>>
>> The initial development of msm nand driver, driver uses the supported
>> NAND devices information as a hardcoded table. Remove the existing
>> hardcoded supported flash device table and read the flash device
>> information from the flash id table which are part of the mtd subsystem.
>
> Why this initial version should be upstream? Why wouldn't you make it
> "standard" first?
>

Currently we are not fully using the MTD nand subsystem. That's the 
intention author has introduced "non-standard" here!!!

Thanks,
Murali N

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
