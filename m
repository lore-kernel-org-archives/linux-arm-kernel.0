From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 00:35:45 -0700
Subject: [PATCH v3 13/13] ARM: dts: ipq8074: Enable few peripherals for
 hk01 board
In-Reply-To: <1521518336-5467-14-git-send-email-sricharan@codeaurora.org>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-14-git-send-email-sricharan@codeaurora.org>
Message-ID: <152153134562.254778.8560281830236357589@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sricharan R (2018-03-19 20:58:56)
> +                        };
> +               };
> +
> +               serial at 78b1000 {
> +                        pinctrl-0 = <&hsuart_pins>;
> +                        pinctrl-names = "default";
> +                        status = "ok";
> +               };
> +
> +               i2c_0 at 78b6000 {

Node should just be called i2c?

> +                        pinctrl-0 = <&i2c_0_pins>;
> +                        pinctrl-names = "default";
> +                        status = "ok";
> +               };
> +
