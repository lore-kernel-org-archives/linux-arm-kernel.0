From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 20:29:30 +0100
Subject: [PATCH] drivers: soc: sunxi: Fix mask generation for SRAM mapping
In-Reply-To: <1453902673-10734-1-git-send-email-jenskuske@gmail.com>
References: <1453902673-10734-1-git-send-email-jenskuske@gmail.com>
Message-ID: <20160127192930.GS4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 02:51:13PM +0100, Jens Kuske wrote:
> GENMASK is inclusive on both ends, therefor one has to be
> subtracted from the width.
> Also fixes the mask for debug output.
> 
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/7ec89987/attachment.sig>
