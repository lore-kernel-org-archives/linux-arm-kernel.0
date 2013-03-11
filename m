From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Mar 2013 21:13:24 +0000
Subject: [GIT PULL] ARM: CSR: minor fixes for 3.9-rc1
In-Reply-To: <CAGsJ_4zyW+jVwDZDTb3TwY9TL+pmub4KGP6K0pgwToa-M2kXxQ@mail.gmail.com>
References: <CAGsJ_4zyW+jVwDZDTb3TwY9TL+pmub4KGP6K0pgwToa-M2kXxQ@mail.gmail.com>
Message-ID: <201303112113.24583.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 March 2013, Barry Song wrote:
> Hi Olof, Arnd,
> 
> The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:
> 
>   Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)
> 
> are available in the git repository at:
>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git sirf/fixes
> 
> Barry Song (1):
>       ARM: prima2: fix a checkpatch issue
> 
> Syam Sidhardhan (1):
>       ARM: prima2: Replace include linux/module.h with linux/export.h
> 
>  arch/arm/mach-prima2/common.c |    4 ++--
>  arch/arm/mach-prima2/pm.c     |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Hi Barry,

Sorry for taking a little longer to look at these patches. I decided
not to apply them because they are only cosmetic changes and can wait
for 3.10.

There are a few things that I'd like you to improve in the future:

* Do not include "Change-Id:" tags in the changelog, those are meaningless
  to the upstream kernel.

* Use a signed tag for pull requests, rather than a branch, and try to
  get your gpg key signed by other maintainers when you meet them at
  a conference.

* In the tag description, give an overview of the patches you are
  asking to be pulled. Most people get it right these days, so there
  are lots of examples for you to look at.

	Arnd
