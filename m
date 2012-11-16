From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Nov 2012 15:41:15 +0900
Subject: [Resend v6 PATCH 2/2] ASoC: atmel-ssc: add pinctrl consumer
In-Reply-To: <50A5DE4E.80206@atmel.com>
References: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
 <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
 <20121116061250.GP4387@opensource.wolfsonmicro.com>
 <50A5DE4E.80206@atmel.com>
Message-ID: <20121116064113.GQ4387@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 02:33:50PM +0800, Bo Shen wrote:
> On 11/16/2012 14:12, Mark Brown wrote:

> >No, this isn't what was meant - the idea is to send only the addition of
> >pinctrl data as one patch, based off the ASoC branch instead of -next.

> What is the pinctrl data? (This patch can be applied on

The data you're adding in the device tree!

> sound/topic/atmel branch without any conflicts)

That's not helpful to anyone doing bisection if there's nothing defining
the pin states, it means that the system won't be able to start the
driver as the API call will fail.

> The other one add pinctrl nodes, must based on -next, or else I
> don't know where should I add the pinctrl nodes.

What makes you say this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/60a95485/attachment.sig>
