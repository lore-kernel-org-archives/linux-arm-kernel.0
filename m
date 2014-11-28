From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 28 Nov 2014 12:06:36 +0000
Subject: [PATCH 2/4] clk: Add INFRA and PERI clocks for Mediatek MT8135.
In-Reply-To: <1417174490-6845-3-git-send-email-jamesjj.liao@mediatek.com>
References: <1417174490-6845-1-git-send-email-jamesjj.liao@mediatek.com>
 <1417174490-6845-3-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20141128120636.GD25883@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 11:34:48AM +0000, James Liao wrote:
> This patch adds clock gates support for Mediatek SoCs, and adds clocks of
> INFRA sys and PERI sys for MT8135.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>  drivers/clk/mediatek/Makefile          |   2 +-
>  drivers/clk/mediatek/clk-gate.c        | 151 +++++++++++++++++++
>  drivers/clk/mediatek/clk-gate.h        |  48 ++++++
>  drivers/clk/mediatek/clk-mt8135.c      | 260 +++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/mt8135-clk.h |  62 ++++++++

Please fold the include/dt-bindings changes into the DT documentation
patch, and put that earlier in the series.

Mark.
