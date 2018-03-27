From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 27 Mar 2018 10:20:34 -0700
Subject: [PATCH v5 08/13] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common
 data
In-Reply-To: <1521800336-19266-9-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-9-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180327172034.GK1403@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +#include "qcom-ipq4019.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1";
> +	compatible = "qcom,ipq4019";

The board should set these, so you shouldn't need to specify them here.
And you should be able to find a more specific compatible for the board.

> +
[..]
> +		qpic-nand at 79b0000 {
> +			status = "ok";

No pinmux for the qpic on these boards?

> +		};
> +	};
> +};

Regards,
Bjorn
