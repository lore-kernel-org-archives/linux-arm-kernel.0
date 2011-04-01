From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Fri, 01 Apr 2011 14:54:35 -0700
Subject: accessing vfpinstr macros from outside vfp directory
In-Reply-To: <1301678843.17592.5.camel@e102144-lin.cambridge.arm.com>
References: <4D924966.2050707@codeaurora.org>
	<1301678843.17592.5.camel@e102144-lin.cambridge.arm.com>
Message-ID: <4D96499B.5070402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/11 10:27, Will Deacon wrote:
> Neil,
> 
> On Tue, 2011-03-29 at 22:04 +0100, Neil Leeder wrote:
>> Any opinions on what would be the best thing to do here? Choices appear to be:
>>
>> 1) allow the relative include path of ../vfp/vfpinstr.h
>> 2) move the definitions of fmrx, fmxr from vfp/vfpinstr.h to include/asm/vfp.h
>> 3) move vfp/vfpinstr.h to include/asm
>> 4) other...?
>>
>> If it helps, I can create a patch for whichever is considered the preferred solution.
>>
> 
> I personally don't find option (1) that offensive - Bryan seemed to
> differ though so perhaps option (2) would keep him happy?
> 
> I don't think option (3) is sensible given that the majority of the
> header file is private to /vfp.
> 
> Will

I raised it as a question.  If that's the only sane thing to do here,
then do it.  Since no one else seems to have chimed in on (2) or (3),
I'm fine with the patch as-is.

- Bryan

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
