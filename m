From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Oct 2016 18:43:22 +0100
Subject: [PATCH/RFT v2 09/17] regulator: fixed: Add over current event
In-Reply-To: <20161024164634.4330-10-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-10-ahaslam@baylibre.com>
Message-ID: <20161024174322.GN17252@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 06:46:26PM +0200, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Some regulator supplies have an over-current pin that is
> activated when the hw detects an over current condition.
> When this happens, the hardware enters a current limited
> mode.

Please don't mix random enhancements like this into bigger system
specific RFC serieses, send them separately so they're easier to spot
and there's no confusion with dependencies and then reference them from
the system specific series when you post that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/3b2c6d6b/attachment.sig>
