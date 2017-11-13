From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Nov 2017 10:25:29 +0100
Subject: [PATCH 2/2] arm64: dts: orange-pi-zero-plus2: enable AP6212a
 WiFi/BT combo
In-Reply-To: <20171103195855.15283-3-geomatsi@gmail.com>
References: <20171103195855.15283-1-geomatsi@gmail.com>
 <20171103195855.15283-3-geomatsi@gmail.com>
Message-ID: <20171113092529.bpvzrrjdyxylx3nx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 10:58:55PM +0300, Sergey Matyukevich wrote:
> Enable AP6212a WiFi/BT combo chip on orange-pi-zero-plus2 board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi REG_ON pin connected to gpio PA9: attach to mmc-pwrseq
> - WiFi HOST_WAKE pin connected to gpio PL7
> - BT is connected to UART1
> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>

Queued for 4.16, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171113/e165f57e/attachment.sig>
