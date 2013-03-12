From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 12 Mar 2013 09:51:41 +0800
Subject: [GIT PULL] ARM: CSR: minor fixes for 3.9-rc1
In-Reply-To: <201303112113.24583.arnd@arndb.de>
References: <CAGsJ_4zyW+jVwDZDTb3TwY9TL+pmub4KGP6K0pgwToa-M2kXxQ@mail.gmail.com>
 <201303112113.24583.arnd@arndb.de>
Message-ID: <CAGsJ_4zWZVxR58XhZtcBa7HA4-dR_SVPU_OQ8j81MtqvFZ0DsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/12 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 06 March 2013, Barry Song wrote:
>> Hi Olof, Arnd,
>>
>> The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:
>>
>>   Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)
>>
>> are available in the git repository at:
>>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git sirf/fixes
>>
>> Barry Song (1):
>>       ARM: prima2: fix a checkpatch issue
>>
>> Syam Sidhardhan (1):
>>       ARM: prima2: Replace include linux/module.h with linux/export.h
>>
>>  arch/arm/mach-prima2/common.c |    4 ++--
>>  arch/arm/mach-prima2/pm.c     |    2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Hi Barry,
>
> Sorry for taking a little longer to look at these patches. I decided
> not to apply them because they are only cosmetic changes and can wait
> for 3.10.

yes. those can wait.

>
> There are a few things that I'd like you to improve in the future:
>
> * Do not include "Change-Id:" tags in the changelog, those are meaningless
>   to the upstream kernel.
>
ok. we are using the gerrit for internal review. so the change-id is
added automatically by the commit-msg hook.
i will seperately handle the commits for upstream and commits for internal repo.

> * Use a signed tag for pull requests, rather than a branch, and try to
>   get your gpg key signed by other maintainers when you meet them at
>   a conference.

ok. hope i will get a guy in shanghai to sign recently.

>
> * In the tag description, give an overview of the patches you are
>   asking to be pulled. Most people get it right these days, so there
>   are lots of examples for you to look at.

ok.

thanks for all of your good suggestions.

>
>         Arnd

-barry
