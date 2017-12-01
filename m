From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Dec 2017 17:02:26 +0100
Subject: [PATCH 1/2] arm64: dts: a64-olinuxino: Enable RTL8723BS WiFi
In-Reply-To: <1512119165-15290-1-git-send-email-jagan@amarulasolutions.com>
References: <1512119165-15290-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20171201160225.mosqfugg5tq763vg@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 02:36:04PM +0530, Jagan Teki wrote:
> Enable RTL8723BS WiFi chip on a64-olinuxino board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi REG_ON pin connected to gpio PL2: attach to mmc-pwrseq
> - WiFi HOST_WAKE pin connected to gpio PL3
> 
> To make rtl8723bs chip to work build it as module to and run
> CONFIG_RTL8723BS=m

You can definitely use that driver without building it as a module.

Once that part of the commit log has been removed,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171201/5fa06d0d/attachment.sig>
