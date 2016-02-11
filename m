From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Feb 2016 11:51:28 +0000
Subject: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
In-Reply-To: <1455145370-20301-4-git-send-email-tony@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-4-git-send-email-tony@atomide.com>
Message-ID: <20160211115128.GF13270@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 03:02:46PM -0800, Tony Lindgren wrote:

> Mark, I'd like to merge this along with other related fixes via
> the ARM SoC tree if no objections, please review and ack if this
> look OK to you.

Why, I'm not seeing any dependencies here?  I'd also expect to be seeing
an awful lot more changes like this, this shouldn't be an OMAP thing -
do we need to fix the core API and then roll out the transition in a
different way?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/735c9e60/attachment.sig>
