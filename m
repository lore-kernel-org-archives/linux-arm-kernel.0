From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Feb 2014 00:10:40 +0900
Subject: [PATCH 06/17] spi: pl022: Let runtime PM callbacks be available
 for CONFIG_PM
In-Reply-To: <CAPDyKFombL2-Rt46QpXPNWe5PeGQnOGmQQNfYd5MdYdEePn-4w@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-7-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFombL2-Rt46QpXPNWe5PeGQnOGmQQNfYd5MdYdEePn-4w@mail.gmail.com>
Message-ID: <20140219151040.GH2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 03:20:07PM +0100, Ulf Hansson wrote:

> Also note that, Russell has already applied the corresponding part in
> the amba bus (patch 1)

Why would this depend on an AMBA patch and if it does surely the two
need to be merged together somehow?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/eb563a42/attachment.sig>
