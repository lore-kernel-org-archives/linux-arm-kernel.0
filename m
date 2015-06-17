From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jun 2015 18:27:19 +0100
Subject: [PATCH 06/13] of/platform: Set fwnode field for new devices
In-Reply-To: <1434548543-22949-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-7-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150617172719.GY14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 03:42:16PM +0200, Tomeu Vizoso wrote:

> When allocating a new platform device, set the fwnode field in the
> struct device to point to the device_node.

Why?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150617/65482507/attachment.sig>
