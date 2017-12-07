From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Dec 2017 11:58:58 +0000
Subject: [PATCH V3] spi: sun4i: disable clocks in the remove function
In-Reply-To: <1512631227-27334-1-git-send-email-takuo.koguchi.sw@hitachi.com>
References: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
 <1512631227-27334-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Message-ID: <20171207115858.rsycg7esimogylbr@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 04:20:14PM +0900, Takuo Koguchi wrote:
> mclk and hclk need to be disabled. Since pm_runtime_disable does
> not disable the clocks, use pm_runtime_force_suspend instead.

Please don't send new patches in reply to existing threads, it makes it
harder to spot them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/5a69ab48/attachment-0001.sig>
