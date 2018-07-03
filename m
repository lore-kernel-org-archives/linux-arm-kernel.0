From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 13:31:46 -0600
Subject: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
In-Reply-To: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180703193146.GA29496@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 02:32:33PM +0800, Anson Huang wrote:
> According to Reference Manual Rev.0, 06/2017,
> there are GPIO LPCGs defined in CCM CCGRs,
> add them into clock tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6sll.c             | 6 ++++++

>  include/dt-bindings/clock/imx6sll-clock.h | 9 ++++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 14 insertions(+), 1 deletion(-)
