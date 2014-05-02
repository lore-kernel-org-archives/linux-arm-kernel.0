From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 May 2014 17:08:01 -0700
Subject: [PATCH] ARM: sunxi: Enable GMAC in sunxi_defconfig
In-Reply-To: <1398710676-9307-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398710676-9307-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140502000801.GL3000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:44:36AM -0700, Maxime Ripard wrote:
> Since the support of the GMAC has been merged, we're using it as the ethernet
> controller on the A20 devices.
> 
> However, sunxi_defconfig wasn't selecting it hence breaking the NFS boot.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to sunxi/fixes-for-3.15

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/9802a3df/attachment.sig>
