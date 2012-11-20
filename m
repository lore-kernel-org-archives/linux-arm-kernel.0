From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Nov 2012 19:27:38 +0900
Subject: [Resend v6 PATCH 2/2] ASoC: atmel-ssc: add pinctrl consumer
In-Reply-To: <50AB4DEA.3090100@atmel.com>
References: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
 <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
 <20121116061250.GP4387@opensource.wolfsonmicro.com>
 <50A5DE4E.80206@atmel.com>
 <20121116064113.GQ4387@opensource.wolfsonmicro.com>
 <50A5E44D.6040501@atmel.com> <50AB4DEA.3090100@atmel.com>
Message-ID: <20121120102712.GF10560@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 05:31:22PM +0800, Bo Shen wrote:

> >based on ASoC tree? And the upper go into pinctrl tree?
> >---<8---
> >ssc0: ssc at fffbc000 {
> >     compatible = "atmel,at91rm9200-ssc";
> >         reg = <0xfffbc000 0x4000>;
> >         interrupts = <14 4 5>;
> >+        pinctrl-names = "default";
> >+        pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
> >         status = "disable";
> >};
> >--->8---

> Any suggestion for this? what should I do with this patch for next?

Send it to pinctrl and we'll deal with the add/add.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/243220af/attachment-0001.sig>
