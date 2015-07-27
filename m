From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jul 2015 11:33:16 +0100
Subject: [PATCH v2 1/4] mfd: max77686: Don't suggest in binding to use a
 deprecated property
In-Reply-To: <55B607B7.6050803@osg.samsung.com>
References: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
 <1437114567-17629-2-git-send-email-javier@osg.samsung.com>
 <20150720081020.GD3061@x1> <55ACC986.5040408@osg.samsung.com>
 <55B607B7.6050803@osg.samsung.com>
Message-ID: <20150727103316.GV11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 12:28:07PM +0200, Javier Martinez Canillas wrote:
> On 07/20/2015 12:12 PM, Javier Martinez Canillas wrote:

> > This PMIC uses a single I2C address for all the regulators and these are
> > controlled by writing to different I2C register addresses. So the regulator
> > nodes don't have a reg property in this case.

> > By looking at other regulators bindings, besides the generic regulator.txt
> > and fixed-regulator.txt DT bindings, there are only 5 (out of 40) that use
> > the node-name at unit-address convention mentioned in the ePAPR document.

> > AFAICT all these are for regulators that are actually in different addresses
> > but I could be wrong so let's see what Mark says.

> Any opinions on this?

I just don't care, this is just syntactic noise which has no practical
meaning as far as I can tell.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150727/c27a7a79/attachment.sig>
