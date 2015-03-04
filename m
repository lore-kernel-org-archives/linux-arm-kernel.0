From: ahs3@redhat.com (Al Stone)
Date: Wed, 04 Mar 2015 16:56:12 -0700
Subject: [PATCH v3 1/9] ACPI: fix all errors reported by cleanpatch.pl
 in osl.c
In-Reply-To: <1528624.HcuCny6IaW@vostro.rjw.lan>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org>
 <1424824585-6405-2-git-send-email-al.stone@linaro.org>
 <1528624.HcuCny6IaW@vostro.rjw.lan>
Message-ID: <54F79B9C.1030901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2015 04:04 PM, Rafael J. Wysocki wrote:
> On Tuesday, February 24, 2015 05:36:17 PM al.stone at linaro.org wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> In preparation for later splitting out some of the arch-dependent code from
>> osl.c, clean up the errors reported by checkpatch.pl.  They fell into these
>> classes:
>>
>>    -- remove the FSF address from the GPL notice
>>    -- "foo * bar" should be "foo *bar" (and the ** variation of same)
>>    -- a return is not a function, so parentheses are not required.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
> 
> checkpatch.pl is irrelevant here.  You're trying to make the coding style be
> more consistent with the coding style of the rest of the kernel.
> 
> The warnings from checkpatch.pl are meaningless for the existing code, so
> it should not be used to justify changes in that code.
> 
> Of course, the same applies to patches [2-4/9].
> 
> 

Okay, I'm puzzled.  In the last version of these patches, I asked if I
should clean up osl.c as long as I was creating the new osi.c file.  I
understood the reply to mean it would also be good to correct osl.c [0]
from checkpatch's point of view.  I took that to mean errors (patch [1/9])
and warnings (patches [2-4/9]) -- so that's what I did.  What did I
misunderstand from that reply?

If these changes are objectionable, then I'll drop these from the next
version of the patch set; I'm not hung up on insisting on either of the
kernel's or ACPI's coding style -- I try to adapt as needed.  I only did
the patches because I thought it was helping out with some long-term
maintenance type work.


[0] https://lkml.org/lkml/2015/2/4/749

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
