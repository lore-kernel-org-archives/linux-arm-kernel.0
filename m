From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 27 Oct 2012 18:44:48 +0200
Subject: [PATCH] arm: mvebu: support for the Globalscale Mirabox MBX0001
 board
In-Reply-To: <1351354965-23875-1-git-send-email-gregory.clement@free-electrons.com>
References: <1351354965-23875-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121027164448.GB15824@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/boot/dts/mbx001.dts b/arch/arm/boot/dts/mbx001.dts
> new file mode 100644
> index 0000000..88a5a11
> --- /dev/null
> +++ b/arch/arm/boot/dts/mbx001.dts

Hi Gregory

Maybe it would be good to prefix this with armada-370. It then fits
with armada-370-db.dts, and all the kirkwood files are kirkwood-*.dts.

     Andrew
