From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 12 Jul 2018 10:37:47 -0300
Subject: [PATCH 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line
 pinumx config
In-Reply-To: <20180712023337.30112-2-andrew.smirnov@gmail.com>
References: <20180712023337.30112-1-andrew.smirnov@gmail.com>
 <20180712023337.30112-2-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5DfHqKjF6xykJtoC-aA-ATWM6mCZR0VzPVpSDOt-Fs6bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Wed, Jul 11, 2018 at 11:33 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> +       pinctrl_switch: switchgrp {
> +               fsl,pins = <
> +                       MX51_PAD_AUD3_BB_CK__GPIO4_20           0xc5

The i.MX51 Reference Manual states that 0xa5 is the default reset
value for the register IOMUXC_SW_PAD_CTL_PAD_AUD3_BB_CK.

By reading your commit log I had the impression you wanted to provide
the default value explicitly.

Please clarify.
