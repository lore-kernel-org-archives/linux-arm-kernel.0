From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 19 Jul 2017 15:58:35 +0800
Subject: [PATCH] clk: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-12-robh@kernel.org>
References: <20170718214339.7774-12-robh@kernel.org>
Message-ID: <1500451115.30067.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-07-18 at 16:42 -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> ---
>  drivers/clk/mediatek/clk-cpumux.c    |  2 +-
>  drivers/clk/mediatek/clk-mtk.c       |  2 +-
>  drivers/clk/mediatek/reset.c         |  2 +-

For clk/mediatek:
Acked-by: James Liao <jamesjj.liao@mediatek.com>


Best regards,

James
