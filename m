From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Aug 2012 23:33:58 +0100
Subject: [PATCH 1/5] ASoC/ARM: Davinci: McASP: split asp header into
 platform and audio specific
In-Reply-To: <1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120817223358.GI18871@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 06:12:01PM +0530, Hebbar, Gururaja wrote:
> Davinci McASP header & driver are shared by few OMAP platforms (like
> TI81xx, AM335x). Splitting asp header into Davinci platform specific
> header and Audio specific header helps to share them across platforms.

This doesn't apply against v3.6-rc2, I suspect there's overlapping
changes in arch/arm.  I was just going to apply it on a separate branch
to allow cross-tree merge if there's overlap with architecture work.
Can you please check and resend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/5839c5b0/attachment.sig>
