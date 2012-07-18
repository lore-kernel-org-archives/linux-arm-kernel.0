From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 17 Jul 2012 21:03:52 -0700
Subject: [PATCH v2 0/2] A couple of clk fixes
In-Reply-To: <1342583543-20404-1-git-send-email-shawn.guo@linaro.org>
References: <1342583543-20404-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAJOA=zNjYRv=8zRyomwRdWm0KSiHV-QdUU2PQzknUrqp3YhnPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 8:52 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> This is v2 of a couple of related clk fixes from myself and Rob. It
> has these two patches be a series and has changes correctly partitioned
> there.
>

Awesome.  I was actually going to make these "partition" changes
manually tomorrow morning and now I don't have to!

Will apply these and push to clk-next after sleeping.

Regards,
Mike

> Rob Herring (1):
>   clk: fix compile for OF && !COMMON_CLK
>
> Shawn Guo (1):
>   clk: fix clk_get on of_clk_get_by_name return check
>
>  drivers/clk/clkdev.c |    4 ++--
>  include/linux/clk.h  |    7 ++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> --
> 1.7.4.1
>
>
