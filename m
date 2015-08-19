From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Aug 2015 09:32:32 -0700
Subject: [PATCH v3 0/8] ARM: sunxi: Add Reduced Serial Bus support
In-Reply-To: <1439958009-14056-1-git-send-email-wens@csie.org>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
Message-ID: <20150819163232.GS10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 12:20:01PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is my third attempt at adding support for Allwinner's Reduced
> Serial Bus (RSB), which is used to communicate with PMICs and other
> peripherals on their newer SoCs, such as the A23/A33/A80.

This is flagged as something that is specific to the Allwinner SoCs.
Why add generic regmap support rather than just implement the regmap
reg_read() and reg_write() in a regmap in the controller driver?  Are
there expected to be other controller drivers from other vendors?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/63d78ebe/attachment.sig>
