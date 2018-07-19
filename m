From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 19 Jul 2018 10:26:12 +0800
Subject: [PATCH 1/2] ARM: dts: hummingboard2: describe optional rs485
In-Reply-To: <8c90900a5d7538d26ec93287ca4787c1dd97fbce.1531798683.git.baruch@tkos.co.il>
References: <8c90900a5d7538d26ec93287ca4787c1dd97fbce.1531798683.git.baruch@tkos.co.il>
Message-ID: <20180719022611.GP4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 06:38:02AM +0300, Baruch Siach wrote:
> A Hummingboard assembly option provides RS-485 transceiver on UART2
> (/dev/ttymxc1). Add DT node for that. Keep it disabled, since RS-485 is
> not assembled by default.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Russell,

Are you okay with these two patches?

Shawn
