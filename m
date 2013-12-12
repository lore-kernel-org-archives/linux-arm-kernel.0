From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 12 Dec 2013 10:08:38 +0800
Subject: [GIT PULL][for 3.14] pull request from pxa
In-Reply-To: <20131212004203.GD21531@quad.lixom.net>
References: <52A823E4.6070208@gmail.com>
 <20131212004203.GD21531@quad.lixom.net>
Message-ID: <52A91AA6.8040700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 08:42 AM, Olof Johansson wrote:
> Hi,
>
> On Wed, Dec 11, 2013 at 04:35:48PM +0800, Haojian Zhuang wrote:
>> Hi Arnd/Olof/Kevin,
>>
>> Please help to merge the pull request for pxa.
>>
>>
>> Best Regards
>> Haojian
>>
>> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>>
>>    Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
>> tags/pxa-for-3.14
>
> These patches are a bit all over the place. I'll take some of them and
> cherry-pick them instead of merging the branch as it is. Since your tree
> is not in linux-next, that shouldn't cause any problems.
>
>>
>> for you to fetch changes up to 8a53a1194f1cc870de0ab9db1728b1ecab770925:
>>
>>    ARM: pxa: remove IRQF_DISABLED (2013-12-11 15:36:24 +0800)
>>
>> ----------------------------------------------------------------
>> Dmitry Eremin-Solenikov (1):
>>        arm: pxa: tosa: fix keys mapping
>
> Ok, that's a fix. Applying to fixes for 3.13 and marking for stable.
>
> Also, please start referring to which commit introduced the breakage, to make
> it easier for people to tell if they need the fix or not. Looks like it's been
> broken since 2010?!
>

This commit exists from v2.6.34.

>>
>> Mike Dunn (2):
>>        PWM: PXA: add device tree support to PWM driver
>
> This patch should go to the PWM maintainer, not to us. Or at least be acked by
> them (but it might as well be merged since there are no dependencies).

Thierry,

I remember that you ask this patch to be merged into armsoc. Please give 
an Ack. Then I could resend the pull request.


Best Regards
Haojian
