From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 11 Mar 2012 00:05:40 -0800
Subject: [GIT PULL 2/4] Samsung devel-pd for v3.4
In-Reply-To: <201203102209.22451.rjw@sisk.pl>
References: <4F5B7C81.6080301@samsung.com>
 <CAOesGMjff3gVNJQ5FpJuSf+uvVDW8k22b+Xcikot-isM-4-6iw@mail.gmail.com>
 <201203102209.22451.rjw@sisk.pl>
Message-ID: <4F5C5CD4.7020804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/12 13:09, Rafael J. Wysocki wrote:
> Hi,
>
> On Saturday, March 10, 2012, Olof Johansson wrote:
>> Hi Rafael,
>>
>> The below series contains two patches that have been sent to you, and
>> that are sitting in the pm-domains branch.
>>
>> Two questions before I pull this into arm-soc:
>>
>> 1) Are you 100% sure this will be submitted to 3.4? And if so, will
>> you send it early during the merge window?
>
> Yes and yes.
>
>> 2) Are you 100% sure you will not rebase the branch into which you
>> pulled the v3.4-for-rafael branch?
>
> Yes, I am.
>
>> I am asking because if we pull this in, and you rebase between now and
>> when it's sent in, we're risking merge conflicts that will be painful
>> to resolve. We've been bitten by that from other dependencies in the
>> past so we're being careful.
>
> Sure, I understand that.
>
> As a general rule, topic braches in my tree whose names start with pm- are
> never rebased (exactly for this reason).
>
Hi,

Rafael, thanks.

Olof, please pull devel-samsung-pd from following:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung-pd

And if any problems, please let me know.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
