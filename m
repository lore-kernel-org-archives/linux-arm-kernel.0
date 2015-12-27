From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Dec 2015 23:03:37 +0100
Subject: [RFC PATCH 1/5] drivers: sunxi-rsb: fix error output type
In-Reply-To: <1450787267-26836-2-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-2-git-send-email-andre.przywara@arm.com>
Message-ID: <20151227220337.GT30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 12:27:43PM +0000, Andre Przywara wrote:
> "len" is actually a size_t in this function here, so properly annotate
> the dev_err printf type to allow compilation for 64-bit architectures.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Queued for 4.6, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151227/02507ba5/attachment.sig>
