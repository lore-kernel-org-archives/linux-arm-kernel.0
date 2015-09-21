From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Sep 2015 09:05:53 +0200
Subject: [PATCH] ARM: sunxi_defconfig: enable MODULE_UNLOAD
In-Reply-To: <1442816002-7821-1-git-send-email-net147@gmail.com>
References: <1442816002-7821-1-git-send-email-net147@gmail.com>
Message-ID: <20150921070553.GK4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 04:13:22PM +1000, Jonathan Liu wrote:
> Loadable module support is enabled so we should allow unloading
> modules too. This also allows lsmod to show values other than "-2" in
> the "Used by" column.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150921/0e843a81/attachment.sig>
