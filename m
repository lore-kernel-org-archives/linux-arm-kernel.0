From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Jun 2014 12:37:10 +0100
Subject: [PATCH] regulator: core: print error value when constraints are
 not applied
In-Reply-To: <1401911605-5157-1-git-send-email-nm@ti.com>
References: <1401911605-5157-1-git-send-email-nm@ti.com>
Message-ID: <20140605113710.GV2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 02:53:25PM -0500, Nishanth Menon wrote:
> With commit 064d5cd110f94ce41ca5681dcda8b77fa63d5b95
> (regulator: core: Fix the init of DT defined fixed regulators)
> We ensure that regulator must be capable of providing it's current
> voltage when constraints are used, however adding the return value in
> the print is a little more informative to explain the nature of the
> failure involved.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140605/d79cda11/attachment.sig>
