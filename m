From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Feb 2018 20:57:27 -0600
Subject: [PATCH 04/15] pinctrl: sh-pfc: Initial R-Car M3-N support
In-Reply-To: <1518515162-23663-5-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-5-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180219025727.6yexb4iqmvlt2luq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 10:45:51AM +0100, Jacopo Mondi wrote:
> Add initial PFC support for R-Car M3-N (r8a77965) SoC.
> No groups or functions defined, just pin and registers enumeration.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
>  drivers/pinctrl/sh-pfc/Makefile                    |    1 +
>  drivers/pinctrl/sh-pfc/core.c                      |    6 +
>  drivers/pinctrl/sh-pfc/pfc-r8a77965.c              | 2728 ++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/sh_pfc.h                    |    1 +
>  6 files changed, 2742 insertions(+)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77965.c
