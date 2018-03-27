From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Mar 2018 12:08:39 -0300
Subject: [PATCH] clk: imx7d: Move clks_init_on before any clock operations
In-Reply-To: <1522160607-7104-1-git-send-email-abel.vesa@nxp.com>
References: <1522160607-7104-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <CAOMZO5C23Va4Frrpqgw8LxEJbfj+cE6xeS3362QzyRn=_wi7JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

On Tue, Mar 27, 2018 at 11:23 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> From: Dong Aisheng <b29396@freescale.com>
>
> For init on clocks we should move it at the first place in imx7d_clocks_init()
> before any clock operations, else the clock operation may fail in case the clock
> is still not on.
>
> Acked-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Thanks for your patches.

You sent 4 patches today touching the same file.

Please annotate the sequence of the patches (1/4, 2/4, etc) so that
the maintainer can clearly know the order the patches should be
applied.
