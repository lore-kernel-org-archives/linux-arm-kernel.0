From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 Dec 2011 09:37:55 +0900
Subject: [PATCH] ARM: EXYNOS: Adds Samsung TRATS board support
In-Reply-To: <000d01ccc381$59fbe660$0df3b320$%kim@samsung.com>
References: <1324624169-16102-1-git-send-email-riverful.kim@samsung.com>
 <088901ccc1dd$deea1e00$9cbe5a00$%kim@samsung.com>
 <CAH9JG2WEcA1BwWq+uovrax5bWvuXaYsGky8D9txymXta7GY8TQ@mail.gmail.com>
 <000d01ccc381$59fbe660$0df3b320$%kim@samsung.com>
Message-ID: <08e201ccc42f$c67e3a50$537aaef0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HeungJun, Kim wrote:
> 
> Hi Kukjun Kim,
> 
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-
> > bounces at lists.infradead.org] On Behalf Of Kyungmin Park
> > Sent: Monday, December 26, 2011 8:56 AM
> > To: Kukjin Kim
> > Cc: HeungJun, Kim; linux-samsung-soc at vger.kernel.org; arm-linux
> > Subject: Re: [PATCH] ARM: EXYNOS: Adds Samsung TRATS board support
> >
> > On 12/24/11, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > > HeungJun, Kim wrote:
> > >>
> > >> This patch adds Samsung Mobile TRATS board support.
> > >>
> > >> Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
> > >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > >> ---
> > >>  arch/arm/mach-exynos/Kconfig       |   11 ++
> > >>  arch/arm/mach-exynos/Makefile      |    1 +
> > >>  arch/arm/mach-exynos/board-trats.c |  340
> > >> ++++++++++++++++++++++++++++++++++++
> > >>  3 files changed, 352 insertions(+), 0 deletions(-)
> > >>  create mode 100644 arch/arm/mach-exynos/board-trats.c
> > >>
> > >
> > > If this is for v3.3, unfortunately, it's a little late to add board
> file and
> > > since many things have changed I don't want to cause the conflicts
> with
> > > others now.
> > >
> > > BTW, why is the name board-xxx not mach-xxx like others?
> >
> > It's mentioned several times,
> > How do you talk with other when talk about the smdk?
> > "I'm using the smdk machine and it's based on smdk machine?"
> > As board is more proper word and it's easy to know when find the board
> > at source code.
> > So hope to use the board if it's not big deal.
> If you don't mind, I want to let you know additional information.
> 
> I also agree with Mr.Park.
> 
> Generally in the robot field, the term "machine" means the total things
> including the machinery part and even the brain "board", and the machine
> is more bigger concept.
> Probably, in the other field, this confusion will be occurred
> when they see the linux kernel source first.
> So, I think these terms might be necessary to distinguish.
> 

Well, I don't think so. I'd like to ask why you _do_ think the meaning of
machine is bigger than board. General robot field?...Nobody knows machine
does not mean board in the arch/arm/ kernel.

If we use the meaning what you said the contrary is rather to be supposed.
The confusion can be caused.
And how about machine_is_xxx() and CONFIG_MACH_XXX for board?

...

Anyway, the board-xxx.c file can be used for it later but as I said, if
required, we need to change it all at once in samsung stuff not just for
TRATS board.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
