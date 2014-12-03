From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Dec 2014 18:26:59 +0000
Subject: [PATCH 1/5] ASoC: dwc: Allocate resources with
 devm_ioremap_resource
In-Reply-To: <547F3C96.9070509@arm.com>
References: <547F3C96.9070509@arm.com>
Message-ID: <20141203182659.GG7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 04:38:46PM +0000, Andrew Jackson wrote:
> Prepare for the introduction of device-tree support by re-ordering some
> of the allocations and using devm_iomap_resource to simplify IO mapping.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/88212cec/attachment.sig>
