From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 24 Jun 2013 11:15:06 -0400
Subject: [PATCH] ARM: Add support for LPAE style CONTEXTIDR
In-Reply-To: <20130624145303.GA25582@mudshark.cambridge.arm.com>
References: <1372080405-13365-1-git-send-email-cov@codeaurora.org>
 <20130624140424.GA24861@mudshark.cambridge.arm.com>
 <51C85A0D.3070400@codeaurora.org>
 <20130624145303.GA25582@mudshark.cambridge.arm.com>
Message-ID: <51C8627A.5000106@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2013 10:53 AM, Will Deacon wrote:
> On Mon, Jun 24, 2013 at 03:39:09PM +0100, Christopher Covington wrote:
>> Hi Will,
>>
>> On 06/24/2013 10:04 AM, Will Deacon wrote:
>> [...]
>>
>>> What's the advantage of this approach, other than you get an extra byte's
>>> worth of PID?
>>
>> In my view, the real advantage is that the the PID is located where people
>> reading ARM Architecture Reference Manual are told they can find it.
> 
> Perhaps, but I'd usually expect a debugger or trace tools to do something
> with the PID, and they likely expect it to be shifted, so you can't really
> win.

But reading and implementing the architecture *is* winning! LOL. I'll file a
ticket with the architecture folks and see what they think.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
