From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Nov 2014 18:59:41 +0000
Subject: [PATCH 1/2 v3] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
In-Reply-To: <1412783423-9408-2-git-send-email-alvin.chen@intel.com>
References: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
 <1412783423-9408-2-git-send-email-alvin.chen@intel.com>
Message-ID: <20141124185941.GH7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 08:50:22AM -0700, Weike Chen wrote:
> There are several registers for SPI, and the registers of 'SSCR0' and 'SSCR1'
> are accessed frequently. This path is to introduce helper functions to
> simplify the accessing of 'SSCR0' and 'SSCR1'.

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/5bde2185/attachment.sig>
