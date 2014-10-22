From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 22 Oct 2014 16:04:12 +0530
Subject: [PATCH v2 0/3] Some cleanup for samsung clock
In-Reply-To: <1411976868-22209-1-git-send-email-pankaj.dubey@samsung.com>
References: <1411976868-22209-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <001201cfede3$c462eb90$4d28c2b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Monday, September 29, 2014 1:18 PM, Pankaj Dubey wrote,
> To: linux-arm-kernel at lists.infradead.org;
linux-samsung-soc at vger.kernel.org
> Cc: kgene.kim at samsung.com; tomasz.figa at gmail.com; s.nawrocki at samsung.com;
> mturquette at linaro.org; naushad at samsung.com; Pankaj Dubey
> Subject: [PATCH v2 0/3] Some cleanup for samsung clock
> 
> This patch series does some cleanup of samsung clock files and fixes one
typo in clk.h
> 
> Changes since v1:
>  - Added patch commit message description to patch 1/3 and 2/3.
> 
> Pankaj Dubey (3):
>   clk: samsung: Spelling s/bwtween/between/
>   clk: samsung: remove unnecessary CONFIG_OF from clk.c
>   clk: samsung: remove unnecessary inclusion of header files from clk.h
> 
>  drivers/clk/samsung/clk.c |    5 ++---
>  drivers/clk/samsung/clk.h |    6 +-----
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 

It there are no comments will you please pick up this patch series.

Thanks,
Pankaj Dubey
> --
> 1.7.9.5
