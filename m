From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jun 2015 18:25:54 +0100
Subject: [PATCH 03/13] ARM: tegra: Add gpio-ranges property
In-Reply-To: <1434548543-22949-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-4-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150617172554.GX14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 03:42:13PM +0200, Tomeu Vizoso wrote:
> Specify how the GPIOs map to the pins in Tegra SoCs, so the dependency is
> explicit.

Can I suggest splitting this sort of patch out of the patch series (and
similarly the documentation fix you had), or putting them at the end or
something?  It's pretty confusing that early patches in the series are
a bit tangential rather than being dependencies for the rest of it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150617/2a9dcd54/attachment.sig>
