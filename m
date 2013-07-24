From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Jul 2013 15:35:11 +0100
Subject: [PATCH 24/27] sound/soc/pxa: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1374602524-3398-25-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
 <1374602524-3398-25-git-send-email-wsa@the-dreams.de>
Message-ID: <20130724143511.GG9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 08:01:57PM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130724/721b0383/attachment-0001.sig>
