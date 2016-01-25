From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Jan 2016 10:27:03 +0100
Subject: [PATCH] pinctrl: sunxi: guard sub-directory with
 CONFIG_PINCTRL_SUNXI
In-Reply-To: <1453563129-30332-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453563129-30332-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160125092703.GK7908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 12:32:09AM +0900, Masahiro Yamada wrote:
> CONFIG_PINCTRL_SUNXI is more suitable than CONFIG_ARCH_SUNXI
> to guard the drivers/pinctrl/sunxi/ directory.
> (I renamed CONFIG_PINCTRL_SUNXI_COMMON to CONFIG_PINCTRL_SUNXI.)
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/d223da20/attachment.sig>
