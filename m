From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 29 Feb 2012 23:19:51 +0000
Subject: [PATCH] regulator mc13783: bail out without platform data
In-Reply-To: <1330502500-30567-1-git-send-email-s.hauer@pengutronix.de>
References: <1330502500-30567-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120229231951.GB8295@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 09:01:40AM +0100, Sascha Hauer wrote:
> the platform data pointer is used without checking it. Bail out
> in the driver instead of crashing the kernel.

Applied, thanks.  Ideally the platform data would just specify the
constraints and the driver would still be able to register the
regulators even without constriants being provided to allow diagnostics.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/42496cfb/attachment.sig>
