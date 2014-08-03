From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 3 Aug 2014 13:56:30 +0200
Subject: [PATCH] ARM: sunxi_defconfig: add NLS_CODEPAGE_437 and
 NLS_ISO8859_1
In-Reply-To: <1406984790-16994-1-git-send-email-libv@skynet.be>
References: <1406984790-16994-1-git-send-email-libv@skynet.be>
Message-ID: <20140803115630.GQ3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Sat, Aug 02, 2014 at 03:06:30PM +0200, Luc Verhaegen wrote:
> Otherwise CONFIG_VFAT_FS is useless as mounting vfat fails.
> 
> Signed-off-by: Luc Verhaegen <libv@skynet.be>

Queued for 3.18.

Since we're pretty much at the beginning of the merge window, I'll
publish the branch whenever -rc1 will be out in order to avoid
rebasing.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140803/cd3d51ef/attachment.sig>
