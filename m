From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 10 Mar 2018 10:57:43 -0300
Subject: [PATCH v2 1/4] dt-bindings: mfd: Add Gateworks System Controller
 bindings
In-Reply-To: <1520287361-12569-2-git-send-email-tharvey@gateworks.com>
References: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
 <1520287361-12569-2-git-send-email-tharvey@gateworks.com>
Message-ID: <CAOMZO5Cw+XW_G_euCL5itmuvfxDDnWWHqg2EjPTCVkuTzqXHug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Mon, Mar 5, 2018 at 7:02 PM, Tim Harvey <tharvey@gateworks.com> wrote:

> +
> +                       hwmon at 1 { /* A1: Input Voltage */
> +                               type = <1>;
> +                               reg = <0x02>;

Unit address (@1) does not match the 'reg' value.

If someone build this example with W=1 a warning will be shown.

Same problem happens in other places of this example.
