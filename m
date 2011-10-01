From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 1 Oct 2011 09:47:19 +0800
Subject: [GIT PULL] ARM: CSR: cleanup some minor coding-style issues for 3.2
Message-ID: <CAGsJ_4w63t=EBFxJM0uum3FBqp5HY0ufi3v4Z+g4s2Hgmh-CzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

The following changes since commit d93dc5c4478c1fd5de85a3e8aece9aad7bbae044:
  Linus Torvalds (1):
        Linux 3.1-rc7

are available in the git repository at:

  git at gitorious.org:sirfprima2-kernel/sirfprima2-kernel.git fixes

Barry Song (4):
      ARM: CSR: timer: do not initialise statics to 0 or NULL
      ARM: CSR: timer: space required before the open parenthesis '('
      ARM: CSR: prima2: fix trailing whitespace
      ARM: CSR: clock: Fix indentation

 arch/arm/mach-prima2/clock.c  |    4 ++--
 arch/arm/mach-prima2/prima2.c |    2 +-
 arch/arm/mach-prima2/timer.c  |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

2011/10/1 Arnd Bergmann <arnd@arndb.de>:
> On Friday 23 September 2011, Barry Song wrote:
>> Barry Song (4):
>> ? ARM: CSR: timer: do not initialise statics to 0 or NULL
>> ? ARM: CSR: timer: space required before the open parenthesis '('
>> ? ARM: CSR: prima2: fix trailing whitespace
>> ? ARM: CSR: clock: Fix indentation
>>
>> ?arch/arm/mach-prima2/clock.c ?| ? ?4 ++--
>> ?arch/arm/mach-prima2/prima2.c | ? ?2 +-
>> ?arch/arm/mach-prima2/timer.c ?| ? ?4 ++--
>> ?3 files changed, 5 insertions(+), 5 deletions(-)
>
>
> Hi Barry,
>
> Sorry for the late reply. This series and the one before all look good
> to me, but I fear I'm losing track of the patches.
>
> Can you send me pull requests for each set (fixes, cleanups, other
> changes) so I can be sure I get everything? If you have trouble
> with git.kernel.org still being down, I can apply the patches
> manually and let you double-check them, but that would be more
> work for both of us I think.
>
> ? ? ? ?Arnd

-barry
