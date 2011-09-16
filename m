From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Sep 2011 10:20:04 -0700
Subject: [PATCH 6/6] ARM: zImage: prevent constant copy+rebuild of
	lib1funcs.S
In-Reply-To: <20110916071554.GB22533@n2100.arm.linux.org.uk>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
	<1315978906-15829-7-git-send-email-nico@fluxnic.net>
	<4E72C96F.5000203@codeaurora.org>
	<20110916071554.GB22533@n2100.arm.linux.org.uk>
Message-ID: <4E738544.4000102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/16/2011 12:15 AM, Russell King - ARM Linux wrote:
> On Thu, Sep 15, 2011 at 08:58:39PM -0700, Stephen Boyd wrote:
>>
>> I already posted a very similar patch and put it into Russell's patch
>> tracker. Can't you just use that instead?
> You did, but then there followed quite a lengthy discussion about it
> so I avoided applying it.  The discussion didn't seem to really reach
> any conclusion wrt the patch so I didn't know what to do about it.

I was under the impression that the kbuild stuff would come later and so
it was safe to apply the patch now (apparently it was because that
happened here).

I guess next time I'll push harder.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
