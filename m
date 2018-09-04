From: robh@kernel.org (Rob Herring)
Date: Tue, 04 Sep 2018 08:36:55 -0500
Subject: [PATCH 6/7] clk: imx6q: add mmdc0 ipg clock
In-Reply-To: <1535701998-20443-7-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
 <1535701998-20443-7-git-send-email-Anson.Huang@nxp.com>
Message-ID: <5b8e8a78.1c69fb81.7f961.8d87@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Aug 2018 15:53:17 +0800, Anson Huang wrote:
> i.MX6Q has MMDC0 ipg clock in CCM CCGR, add it into
> clock tree for clock management.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6q.c               | 1 +
>  include/dt-bindings/clock/imx6qdl-clock.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
