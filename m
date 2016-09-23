From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 10:11:42 -0500
Subject: [PATCH 18/19] stmmac: dwmac-sti: Remove obsolete STi platforms
In-Reply-To: <1473859677-9231-19-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-19-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160923151142.GG9176@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 02:27:56PM +0100, Peter Griffin wrote:
> This patch removes support for STiH415/6 SoC's from the
> dwmac-sti driver and dt binding doc, as support for these
> platforms is being removed from the kernel. It also removes
> STiD127 related code, which has never actually been supported
> upstream.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <peppe.cavallaro@st.com>
> Cc: <alexandre.torgue@st.com>
> Cc: <netdev@vger.kernel.org>
> ---
>  .../devicetree/bindings/net/sti-dwmac.txt          |  3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    | 37 ----------------------
>  2 files changed, 1 insertion(+), 39 deletions(-)
