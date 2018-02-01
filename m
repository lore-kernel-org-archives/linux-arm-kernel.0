From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 2 Feb 2018 02:12:24 +0900
Subject: [PATCH 07/11] MIPS: BCM63XX: kconfig: Remove blank help text
In-Reply-To: <20180131093434.20050-8-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
 <20180131093434.20050-8-ulfalizer@gmail.com>
Message-ID: <CAK7LNAR5ji4mi7vOOUV+PDZWrbhSEuin-Qj0AMkE8-mW+CTmug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-31 18:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> Blank help texts are probably either a typo, a Kconfig misunderstanding,
> or some kind of half-committing to adding a help text (in which case a
> TODO comment would be clearer, if the help text really can't be added
> right away).
>
> Best to remove them, IMO.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---


FYI.

I picked up this patch to kbuild
because I need this to suppress warning messages
introduced by 11/11.

I am planning to send a PR for this series next week.

-- 
Best Regards
Masahiro Yamada
