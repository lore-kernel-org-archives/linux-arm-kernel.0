From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 28 Mar 2012 17:24:04 +0200
Subject: [GIT PULL] pull request from arch-pxa git on fixes branch
In-Reply-To: <CAN1soZytJ-CxepQAZn5oZ06=ezTQ85O-iC7tUDOeWqi=zpuf8A@mail.gmail.com>
References: <CAN1soZytJ-CxepQAZn5oZ06=ezTQ85O-iC7tUDOeWqi=zpuf8A@mail.gmail.com>
Message-ID: <4F732D14.3020803@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On 03/28/12 15:51, Haojian Zhuang wrote:
> Hi Arnd & Olof,
> 
> Please help to pull fixes branch in arch-pxa git. This fix can resolve
> build issues on updating regulator interface.
> 
> The following changes since commit c16fa4f2ad19908a47c63d8fa436a1178438c7e7:
> 
>   Linux 3.3 (2012-03-18 16:15:34 -0700)
> 
> are available in the git repository at:
>   git://github.com/hzhuang1/linux.git fixes
> 
> Paul Gortmaker (1):
>       ARM: pxa: fix regulator related build fail in magician_defconfig
> 
>  arch/arm/mach-pxa/hx4700.c   |    2 --
>  arch/arm/mach-pxa/magician.c |    2 --
>  2 files changed, 0 insertions(+), 4 deletions(-)

Can Paul's patch [1] be included in this or later request?

Thanks.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/091750.html


-- 
Regards,
Igor.
