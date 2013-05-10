From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 May 2013 11:55:45 +0100
Subject: [RFC 23/42] drivers/spi: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368173847-5661-24-git-send-email-wsa@the-dreams.de>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-24-git-send-email-wsa@the-dreams.de>
Message-ID: <20130510105545.GO3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 10:17:08AM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130510/c2f62849/attachment.sig>
