From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Dec 2017 10:18:47 +0100
Subject: [PATCH V3] spi: sun4i: disable clocks in the remove function
In-Reply-To: <1512631227-27334-1-git-send-email-takuo.koguchi.sw@hitachi.com>
References: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
 <1512631227-27334-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Message-ID: <20171207091847.rf76dol6iqcfeomr@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 07, 2017 at 04:20:14PM +0900, Takuo Koguchi wrote:
> mclk and hclk need to be disabled. Since pm_runtime_disable does
> not disable the clocks, use pm_runtime_force_suspend instead.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/ba561d5f/attachment.sig>
