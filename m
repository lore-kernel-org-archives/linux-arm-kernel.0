From: davidb@codeaurora.org (David Brown)
Date: Wed, 23 Mar 2011 11:10:42 -0700
Subject: [Git pull] MSM for v2.6.39
In-Reply-To: <1300890191.6117.43.camel@m0nster> (Daniel Walker's message of
	"Wed, 23 Mar 2011 07:23:11 -0700")
References: <8yazkotpwk6.fsf@huya.qualcomm.com>
	<1300890191.6117.43.camel@m0nster>
Message-ID: <8yapqphhfml.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23 2011, Daniel Walker wrote:

> On Thu, 2011-03-17 at 08:59 -0700, David Brown wrote:
>> David Brown (16):
>>       msm: Add CPU queries
>>       msm: Generalize timer register mappings
>>       msm: Generalize QGIC registers
>>       msm: Add MSM 8960 cpu_is check
>>       Merge branch 'msm-uart' into for-next
>>       Merge branch 'msm-8960' into for-next
>>       Merge branch 'msm-sdcc' into for-next
>>       Merge branch 'msm-fb' into for-next
>>       Merge branch 'msm-8960' into msm-core
>>       msm: Remove broken register definition from trout
>>       msm: Warning fix in trout gpio board file
>>       Merge branch 'msm-core' into for-next
>>       Merge branch 'msm-core' into for-next
>>       Merge branch 'msm-core' into for-next
>>       msm: Use explicit GPLv2 licenses
>>       Merge remote branch 'rmk/for-linus' into for-linus 
>
> Could you change the "for-next" name to something more interesting like
> msm-for-linus .. I think it would be acceptable to just create
> msm-for-linus during the merge window and merge all the sub-tree's into
> that.

I think the problem was that these trees came in, intended for
linux-next, and were pulled into that branch.  Then, I published that as
the tree for the pull-request 'for-linus', but nothing was actually
merged into that tree.

I can do a separate merge into the 'for-linus' tree before the merge
window, but then I won't be giving a pull request for the same commit as
what has been being tested in linux-next.  I'm not sure what is
preferred here.  Doing a separate merge at the end has the benefit of
reducing the number of intermediate merges.  The tree sha will be the
same in either case, so it's really a matter what the history should
look like.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
