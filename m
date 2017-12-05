From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 09:34:19 +0100
Subject: [PATCH v2 1/2] arm64: dts: a64-olinuxino: Enable RTL8723BS WiFi
In-Reply-To: <1512363187-8353-1-git-send-email-jagan@amarulasolutions.com>
References: <1512363187-8353-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20171205083419.u3a76d4awv3byv35@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 10:23:06AM +0530, Jagan Teki wrote:
> Enable RTL8723BS WiFi chip on a64-olinuxino board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi REG_ON pin connected to gpio PL2: attach to mmc-pwrseq
> - WiFi HOST_WAKE pin connected to gpio PL3
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/e6b2cd13/attachment.sig>
