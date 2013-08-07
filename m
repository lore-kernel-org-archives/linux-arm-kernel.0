From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 7 Aug 2013 18:12:07 -0400
Subject: [GIT PULL 00/26] Third round of Renesas ARM based SoC cleanups
 for v3.12
In-Reply-To: <20130807220916.GA24734@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
 <52024B56.4030403@ti.com> <20130807220916.GA24734@verge.net.au>
Message-ID: <5202C637.8040301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 August 2013 06:09 PM, Simon Horman wrote:
> On Wed, Aug 07, 2013 at 09:27:50AM -0400, Santosh Shilimkar wrote:
>> Simon,
>>
>> On Wednesday 07 August 2013 12:38 AM, Simon Horman wrote:
>>> Hi Olof, Hi Arnd,
>>>
>>> please consider this third round of Renesas ARM based SoC cleanups for
>>> v3.12.
>>>
>>> This pull-request is based on a merge of renesas-cleanup2-for-v3.12 and
>>> renesas-dt2-for-v3.12 which I have previously sent pull-requests for.
>>>
>>> This pull-request has some minor conflicts:
>>>
>>> * There are some conflicts with renesas-multiplatform-for-v3.12,
>>>   which I have previously sent a pull request for,
>>>   in arch/arm/mach-shmobile/Makefile.
>>>
>>> I have provided an example of how to merge these as part of
>>> the renesas-devel-20180807 tag in the renesas tree.
>>>
>>>
>>> The following changes since commit 4e0f3fcfe2f3716e3fa9c442cee93211bf2ac793:
>>>
>>>   Merge branch 'dt2' into cleanup3-base (2013-08-06 18:06:53 +0900)
>>>
>>> are available in the git repository at:
>>>
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup3-for-v3.12
>>>
>>> for you to fetch changes up to 282b583f752f996ee5c33b0cdc18adf3b5094ee0:
>>>
>>>   ARM: shmobile: sh73a0: Remove global GPIO_NR definition (2013-08-06 18:07:13 +0900)
>>>
>> Just out of curiosity, looks like you have "GIT PULL" starting subject line on
>> every patches as well as the cover-letter which seems to be the pull request.
>>
>> It apears like you have sent 26 pull request;-).
> 
> I can go back to using "PATCH" as the prefix on the patches itself
> if that is preferred. I made this change to help me not to forget
> to set the subject prefix on the first message to "GIT PULL".
> 
You can avoid that by sending patch series followed by a pull request
email(separate). Thats what at least what I see everyone doing.

Regards,
Santosh
