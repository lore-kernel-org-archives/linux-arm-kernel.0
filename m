From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 16:45:52 +0200
Subject: [PATCH 1/1] devicetree: sunxi: Add OLinuXino Lime2 eMMC to the
 Makefile
In-Reply-To: <1463169436-6170-1-git-send-email-oliver@schinagl.nl>
References: <1463169436-6170-1-git-send-email-oliver@schinagl.nl>
Message-ID: <20160516144552.GH27618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 09:57:16PM +0200, Olliver Schinagl wrote:
> commit 27dd9af6bc000ab21fd ("ARM: dts: sunxi: Add a olinuxino-lime2-emmc")
> added the new emmc equipped lime2 but forgot its Makefile.
> 
> This patch adds an entry to the Makefile.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>

Having the version of the patch would be nice too.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Arnd, Kevin, Olof, could you apply that patch directly for 4.7?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160516/4b9a8049/attachment.sig>
