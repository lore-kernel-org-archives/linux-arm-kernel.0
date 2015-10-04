From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 4 Oct 2015 16:16:39 +0200
Subject: [PATCH v5 2/5] soc: sunxi: Add driver for Allwinner Reduced
 Serial Bus
In-Reply-To: <1443700673-24312-3-git-send-email-wens@csie.org>
References: <1443700673-24312-1-git-send-email-wens@csie.org>
 <1443700673-24312-3-git-send-email-wens@csie.org>
Message-ID: <20151004141639.GD2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 01, 2015 at 07:57:48PM +0800, Chen-Yu Tsai wrote:
> Reduced Serial Bus (RSB) is an Allwinner proprietery interface
> used to communicate with PMICs and other peripheral ICs.
> 
> RSB is a two-wire push-pull serial bus that supports 1 master
> device and up to 15 active slave devices.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151004/b4311fb9/attachment.sig>
