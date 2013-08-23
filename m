From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Aug 2013 13:01:56 +0100
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <52174D25.9050805@gmail.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <201308222229.01778.marex@denx.de>
 <20130822233611.GA25263@sirena.org.uk>
 <201308230158.05909.marex@denx.de>
 <20130823094141.GE25263@sirena.org.uk> <52174BAC.3070901@gmail.com>
 <52174D25.9050805@gmail.com>
Message-ID: <20130823120156.GH25263@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 04:53:09AM -0700, Brian Norris wrote:
> On 08/23/2013 04:46 AM, Brian Norris wrote:

> >     Signed-off-by: wangyuhang <wangyuhang2014@gmail.com>
> >     Signed-off-by: Mark Brown <broonie@linaro.org>

> Speaking of which, the new device-tree properties are not documented
> in Documentation/devicetree/bindings/spi/spi-bus.txt yet.

Yes, indeed - if you look at the review you'll see I asked for a
followup patch doing that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/21873702/attachment.sig>
