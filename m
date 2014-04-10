From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Apr 2014 14:47:05 +0200
Subject: [PATCH v2 5/5] ARM: sunxi: update the default ARCH_NR_GPIO for
 sunxi arch
In-Reply-To: <1397132747-13917-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397132747-13917-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140410124705.GT28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 02:25:47PM +0200, Boris BREZILLON wrote:
> The A31 SoC has PL and PM banks, we thus need to increase the default
> ARCH_NR_GPIO when building for the sunxi architecture.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/03ded9ae/attachment.sig>
