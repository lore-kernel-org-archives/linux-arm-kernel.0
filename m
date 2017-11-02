From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 19:02:46 -0500
Subject: [PATCH 2/3] clk: owl: add clock driver for Actions S900 SoC
In-Reply-To: <1509479663-8985-3-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1509479663-8985-1-git-send-email-manivannan.sadhasivam@linaro.org>
 <1509479663-8985-3-git-send-email-manivannan.sadhasivam@linaro.org>
Message-ID: <20171102000246.rcermsfe7rycrmk3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 01:24:22AM +0530, Manivannan Sadhasivam wrote:
> This patch adds clock driver for Actions Semi OWL
> series S900 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS                                    |   5 +
>  drivers/clk/Makefile                           |   1 +
>  drivers/clk/owl/Makefile                       |   2 +
>  drivers/clk/owl/clk-factor.c                   | 270 ++++++++++++
>  drivers/clk/owl/clk-pll.c                      | 346 +++++++++++++++
>  drivers/clk/owl/clk-s900.c                     | 587 +++++++++++++++++++++++++
>  drivers/clk/owl/clk.c                          | 318 ++++++++++++++
>  drivers/clk/owl/clk.h                          | 301 +++++++++++++

>  include/dt-bindings/clock/actions,s900-clock.h | 141 ++++++

This belongs in the DT binding patch.

>  9 files changed, 1971 insertions(+)
>  create mode 100644 drivers/clk/owl/Makefile
>  create mode 100644 drivers/clk/owl/clk-factor.c
>  create mode 100644 drivers/clk/owl/clk-pll.c
>  create mode 100644 drivers/clk/owl/clk-s900.c
>  create mode 100644 drivers/clk/owl/clk.c
>  create mode 100644 drivers/clk/owl/clk.h
>  create mode 100644 include/dt-bindings/clock/actions,s900-clock.h
