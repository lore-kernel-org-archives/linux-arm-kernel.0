From: chlrbgh0@gmail.com (Kyuho Choi)
Date: Tue, 20 Nov 2012 14:04:04 +0900
Subject: [PATCH] ARM: EXYNOS: Add support for ORIGEN4QUAD board
In-Reply-To: <0b6801cdc6d8$e98c1600$bca44200$@org>
References: <1353345846-31355-1-git-send-email-kh.choi@insignal.co.kr>
 <0b6801cdc6d8$e98c1600$bca44200$@org>
Message-ID: <CAP2JTQ+KW0agS_4gNvfFJRoA7-sogb4=8Pu5MvDMfYxyus-o_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/20 Kukjin Kim <kgene@kernel.org>

> chlrbgh0 at gmail.com wrote:
> >
> > From: Kyuho Choi <kh.choi@insignal.co.kr>
> >
> > This patch add support for Insignal ORIGEN4QUAD board.
> > ORIGEN4QUAD board based on Samsung Exynos4412 SoC.
> >
> > Signed-off-by: Kyuho Choi <kh.choi@insignal.co.kr>
> > ---
> >  arch/arm/mach-exynos/Kconfig       |    1 +
> >  arch/arm/mach-exynos/mach-origen.c |   74
> +++++++++++++++++++++++++++-----
> > ---
> >  2 files changed, 58 insertions(+), 17 deletions(-)
> >
> Hmm...at this moment, I don't want to update non-DT stuff for exynos,
> because I have a plan to move on supporting only DT for all of exynos next
> time.
>
> Please submit DT patches for the ORIGEN4QUAD board.
>
> Thanks.
>
Okay. I'll prepare and submit DT patches for ORIGEN4QUAD board. :)

>
> K-Gene <kgene@kernel.org>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/4be4cd2e/attachment-0001.html>
