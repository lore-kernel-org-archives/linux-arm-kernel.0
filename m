From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 May 2016 20:09:41 +0200
Subject: [PATCHv4] ARM: dts: sunxi: Add a olinuxino-lime2-emmc
In-Reply-To: <1462439332-26215-1-git-send-email-oliver@schinagl.nl>
References: <1462439332-26215-1-git-send-email-oliver@schinagl.nl>
Message-ID: <20160508180941.GC6167@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 11:08:52AM +0200, Olliver Schinagl wrote:
> There are 3 kinds of OLinuXino Lime2 boards.
> One without any on board storage, one with NAND storage and one with
> eMMC storage. This patch adds the eMMC variant of boards.
> 
> eMMC storage is different from a regular SD card in that it is soldered
> on the board and cannot be changed. Additionally, it shares pins with
> the NAND module and with the second SPI port.
> 
> Changeslog:
> 
> v4:
>   Add board compatibles
> 
> v3:
>   Add pwr-seq-emmc with the reset gpio
> 
> v2:
>   Remove unsupported no-1.8-v property, add vqmmc property
> 
> v1:
>   Initial bare bone version

This is not something we want in the commit log. This should go below
the --- so that it's dropped when applied.

Removed and applied.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160508/9683f589/attachment.sig>
