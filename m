From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Mar 2014 13:45:04 +0000
Subject: [PATCH v4 1/5] mfd: add bcm590xx pmu DT binding
In-Reply-To: <20140312133339.GC17461@e106331-lin.cambridge.arm.com>
References: <1394580837-8331-1-git-send-email-mporter@linaro.org>
 <1394580837-8331-2-git-send-email-mporter@linaro.org>
 <20140312133339.GC17461@e106331-lin.cambridge.arm.com>
Message-ID: <20140312134504.GT28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 01:33:39PM +0000, Mark Rutland wrote:
> On Tue, Mar 11, 2014 at 11:33:53PM +0000, Matt Porter wrote:

> > +			rfldo_reg: rfldo {
> > +				regulator-min-microvolt = <1200000>;
> > +				regulator-max-microvolt = <3300000>;

> Are any specific properties required on these children?

Regulator nodes can be completely empty (or missing) - for most drivers
there's nothing driver specific, the standard binding covers everything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/a2fa89e2/attachment.sig>
