From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Jun 2017 02:38:36 -0700
Subject: [PATCH 1/2] ARM: dts: dm816x: Correct NAND support nodes
In-Reply-To: <1498045347-27324-1-git-send-email-trini@konsulko.com>
References: <1498045347-27324-1-git-send-email-trini@konsulko.com>
Message-ID: <20170626093835.GU3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tom Rini <trini@konsulko.com> [170621 04:42]:
> The ELM node in dm816x.dtsi needs to declare the correct compatible
> value here as per the binding only one value is correct, and the current
> driver handles it correctly.  We then add pinmux information for the
> NAND found on the EVM so that we do not rely on the ROM to do this for
> us, and also so that we do not try and probe NAND before we probe the
> ELM.

OK applying into omap-for-v4.13/dt as it's a fix. Only taking fixes
until -rc1 FYI all.

Regards,

Tony
