From: khilman@ti.com (Kevin Hilman)
Date: Wed, 05 Jan 2011 09:20:00 -0800
Subject: [PATCH 0/5] omap2plus: Trivial build break fixes
In-Reply-To: <6a39d0124306a5ac6b567edca88f0671@mail.gmail.com> (Santosh
	Shilimkar's message of "Wed, 5 Jan 2011 16:28:47 +0530")
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	<8762u4423o.fsf@ti.com>
	<6a39d0124306a5ac6b567edca88f0671@mail.gmail.com>
Message-ID: <87r5crz2rj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

[...]

>> Minor nit in your git-send-email config.
>>
>> Can you add the following to your ~/.gitconfig, or update to newer
>> git
>> where this is now the default:
>>
>> [sendemail]
>> 	chainreplyto = false
>>
>> This will make all patches a reply to PATCH 0 instead of to the
>> previous
>> patch.
>>
> Have tried this in v2 I posted but it didn't appear to be a
> reply for PATCH 0.

You didn't have (or I didn't see) a PATCH 0 in your v2 version.  After
patch 1, all patches are replies to patch 1 (using In-Reply-To: and
References:) resulting in proper threading.

> May be I missed something.

I don't think so, it looks right now.

Kevin
