From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jan 2017 11:49:09 -0600
Subject: [PATCH v2 04/12] driver: clk: imx: Add clock driver for imx6sll
In-Reply-To: <1482832070-22668-5-git-send-email-ping.bai@nxp.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-5-git-send-email-ping.bai@nxp.com>
Message-ID: <20170103174909.3a5qtds4fpmgzhxs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 05:47:42PM +0800, Bai Ping wrote:
> Add clk driver support for imx6sll.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  drivers/clk/imx/Makefile                  |   1 +
>  drivers/clk/imx/clk-imx6sll.c             | 369 ++++++++++++++++++++++++++++++

>  include/dt-bindings/clock/imx6sll-clock.h | 204 +++++++++++++++++

This should be part of the binding doc patch.

>  3 files changed, 574 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imx6sll.c
>  create mode 100644 include/dt-bindings/clock/imx6sll-clock.h
