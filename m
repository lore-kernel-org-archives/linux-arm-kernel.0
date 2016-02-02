From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Tue, 2 Feb 2016 17:19:15 +0000
Subject: [PATCH v3 1/2] clk: sunxi: Add sun6i/8i video support
In-Reply-To: <8fdfe5fe7715f19416d654964e55721b30237b38.1454427224.git.moinejf@free.fr>
References: <cover.1454427223.git.moinejf@free.fr>
 <8fdfe5fe7715f19416d654964e55721b30237b38.1454427224.git.moinejf@free.fr>
Message-ID: <CACvgo53f8Sr_dEAx_mcvjXciK01mY7TUDguOJ-HzNur-PpmMZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Francois,

On 1 February 2016 at 07:43, Jean-Francois Moine <moinejf@free.fr> wrote:
> Add the clock types which are used by the sun6i/8i families for video.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> v3: (no change)
> v2:
>         - remarks from Chen-Yu Tsai
>         - DT documentation added
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
>  drivers/clk/sunxi/clk-sun6i-display.c             | 106 +++++++++++++
>  drivers/clk/sunxi/clk-sun6i-pll3.c                | 174 ++++++++++++++++++++++
>  3 files changed, 282 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-sun6i-display.c
>  create mode 100644 drivers/clk/sunxi/clk-sun6i-pll3.c
>
Something is missing here - namely the changes to the Makefile. Does
this series work or did you simply forget git add ?

Regards,
Emil
