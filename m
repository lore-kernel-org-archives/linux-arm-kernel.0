From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 May 2016 12:55:46 +0200
Subject: [PATCH 1/1] ARM: dts: sunxi: Add a olinuxino-lime2-emmc
In-Reply-To: <1461827998-12192-1-git-send-email-oliver@schinagl.nl>
References: <1461827998-12192-1-git-send-email-oliver@schinagl.nl>
Message-ID: <20160502105546.GN17159@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 28, 2016 at 09:19:58AM +0200, Olliver Schinagl wrote:
> There are 3 kinds of OLinuXino Lime2 boards.
> One without any on board storage, one with NAND storage and one with
> eMMC storage. This patch adds the eMMC variant of boards.
> 
> eMMC storage is different from a regular SD card in that it is soldered
> on the board and cannot be changed. Additionally, it shares pins with
> the NAND module and with the second SPI port.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>

Is it a publicly available board, or is it a private hack you made
yourself?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/16ec5bd4/attachment.sig>
