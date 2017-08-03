From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 13:39:14 -0500
Subject: [PATCH] clk: uniphier: remove sLD3 SoC support
In-Reply-To: <1501040075-24279-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501040075-24279-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170803183914.dxus5l2dgscfx6gi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 12:34:35PM +0900, Masahiro Yamada wrote:
> This SoC is too old.  It is difficult to maintain any longer.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../devicetree/bindings/clock/uniphier-clock.txt   |  5 ---
>  drivers/clk/uniphier/clk-uniphier-core.c           | 16 +++------
>  drivers/clk/uniphier/clk-uniphier-mio.c            |  4 +--
>  drivers/clk/uniphier/clk-uniphier-sys.c            | 42 ++++++++--------------
>  drivers/clk/uniphier/clk-uniphier.h                |  3 +-
>  5 files changed, 20 insertions(+), 50 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
