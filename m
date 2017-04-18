From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Apr 2017 20:49:34 +0100
Subject: [PATCH 0/7] regulator: arizona: Prepare for sharing with Madera
 codecs
In-Reply-To: <1492512234-19210-1-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1492512234-19210-1-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <20170418194934.kbuckzbdd6pkis25@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 11:43:46AM +0100, Richard Fitzgerald wrote:
> These patches make various changes to the Arizona regulators so that they
> can be re-used for the Cirrus Madera codecs:

This all looks good to me but needs review from Lee for the MFD overlap.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/497281d0/attachment.sig>
