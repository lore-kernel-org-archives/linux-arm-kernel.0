From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Dec 2015 23:05:49 +0100
Subject: [RFC PATCH 3/5] crypto: sunxi-ss: fix dev_dbg() output type
In-Reply-To: <1450787267-26836-4-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-4-git-send-email-andre.przywara@arm.com>
Message-ID: <20151227220549.GV30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 12:27:45PM +0000, Andre Przywara wrote:
> The length parameter in this dev_dbg() call is actually a size_t,
> so use the proper type to avoid warnings when compiling for 64-bit
> architectures.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151227/d5a6521c/attachment.sig>
