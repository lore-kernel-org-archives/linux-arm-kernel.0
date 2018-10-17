From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Oct 2018 10:02:41 -0300
Subject: [PATCH v4 2/4] crypto: mxs-dcp - Add support for dcp clk
In-Reply-To: <a97517bf72f649915bccf555ab7d3c8c4551298d.camel@nxp.com>
References: <cover.1539779579.git.leonard.crestez@nxp.com>
 <95dce7010676581691b1ac9906e9298470e0aa1a.1539779579.git.leonard.crestez@nxp.com>
 <CAOMZO5BMeHjsyZWhUb5RmEBRCYViUN-Vx8KyLBWtDJGKBHHpCg@mail.gmail.com>
 <a97517bf72f649915bccf555ab7d3c8c4551298d.camel@nxp.com>
Message-ID: <CAOMZO5DCzM_NnqD4tHTAn4pAaUdQGo38Ami1h3pu9SzgyQ7GnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 9:59 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:

> There is a changelog in the cover letter.

It did not show up:
https://lkml.org/lkml/2018/10/17/673

> This only looks slightly odd in git diff but it's not unrelated.
>
> I placed clk get/prepare/enable just before stmp_reset_block and made
> stmp_reset_block print a message and goto err_disable_unprepare_clk on
> failure instead of just "if (ret) return ret;"

Got it! Then it looks fine, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
