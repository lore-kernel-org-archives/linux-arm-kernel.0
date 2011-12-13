From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 13 Dec 2011 15:27:16 +0200
Subject: [PATCH 1/3] ARM: OMAP2+: kconfig: Enable devicetree by default
 for OMAP2+ systems
In-Reply-To: <1323190149-6492-2-git-send-email-b-cousson@ti.com>
References: <y>  <1323190149-6492-2-git-send-email-b-cousson@ti.com>
Message-ID: <1323782836.1877.79.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2011-12-06 at 17:49 +0100, Benoit Cousson wrote:
> devicetree will become the mandatory boot method for OMAP2+.
> In order to avoid cluttering the OMAP code with #ifdef CONFIG_OF,
> select USE_OF by default for every OMAP2+ systems.
> Select as well the APPENDED_DTB and ATAG_DTB_COMPAT to allow legacy
> boot loader to keep working properly.

APPENDED_DTB sounds a bit dangerous to be enabled by default according
to the config help text.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111213/4fa39ab4/attachment.sig>
