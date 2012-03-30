From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 30 Mar 2012 09:06:37 +0800
Subject: [GIT PULL] pull request from arch-pxa git on fixes branch
In-Reply-To: <CAOesGMgxq-HEeKSPvaW-kTLqNyDJUUmG0OEpockMBNninQL0wQ@mail.gmail.com>
References: <CAN1soZytJ-CxepQAZn5oZ06=ezTQ85O-iC7tUDOeWqi=zpuf8A@mail.gmail.com>
 <4F732D14.3020803@compulab.co.il>
 <CAOesGMgxq-HEeKSPvaW-kTLqNyDJUUmG0OEpockMBNninQL0wQ@mail.gmail.com>
Message-ID: <CAN1soZzqxy=wsPVEXY8BxTK24szq7x5Oxk2JjuUJ6di7ij8hWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 1:12 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Wed, Mar 28, 2012 at 8:24 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>
>> Can Paul's patch [1] be included in this or later request?
>>
>> Thanks.
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/091750.html
>
> Yes, Haojian, please add that to the branch (with the proposed fixups)
> as well so we can pick it up and send it in ASAP. Both are broken
> today in Russell's PXA defconfig.
>
> There is one more failure as well, that I haven't seen a patch posted for:
>
> arch/arm/mach-pxa/cm-x300.c:716:3: error: unknown field 'dev'
> specified in initializer
>
>
>
> -Olof

Now these build issues are fixed. Could you help to pull these fixes
from arch-pxa git?

The following changes since commit c16fa4f2ad19908a47c63d8fa436a1178438c7e7:

  Linux 3.3 (2012-03-18 16:15:34 -0700)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git fixes

Haojian Zhuang (2):
      ARM: pxa: fix build issue on cm-x300
      ARM: pxa: fix build issue on stargate2

Paul Gortmaker (2):
      ARM: pxa: fix regulator related build fail in magician_defconfig
      ARM: pxa: fix build failure for regulator consumer in em-x270.c

 arch/arm/mach-pxa/cm-x300.c   |    1 -
 arch/arm/mach-pxa/em-x270.c   |   10 +++++-----
 arch/arm/mach-pxa/hx4700.c    |    2 --
 arch/arm/mach-pxa/magician.c  |    2 --
 arch/arm/mach-pxa/stargate2.c |    2 +-
 5 files changed, 6 insertions(+), 11 deletions(-)
