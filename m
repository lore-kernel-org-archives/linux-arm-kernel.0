From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Feb 2014 13:46:15 +0900
Subject: [PATCH 2/2] ARM: u300: switch SSP/SPI clock name to "SSPCLK"
In-Reply-To: <1393246638-16236-1-git-send-email-linus.walleij@linaro.org>
References: <1393246638-16236-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140225044615.GZ25940@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 01:57:18PM +0100, Linus Walleij wrote:
> As noted in recent discussions the name of the core clock for
> the PL022 derived SPI blocks is erroneously named in the
> U300 device tree. The kernel doesn't currently use the name,
> but may do so soon so let use rename all these clocks in
> accordance with the name given in the PL022 TRM (ARM DDI 0194G).

Reviewed-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/62068059/attachment.sig>
