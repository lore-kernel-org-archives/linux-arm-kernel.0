From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Jun 2012 19:56:38 +0100
Subject: [PATCH 08/14] mfd: Add IRQ domain support for the AB8500
In-Reply-To: <20120618102003.GB12029@n2100.arm.linux.org.uk>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-9-git-send-email-lee.jones@linaro.org>
 <20120614183231.GA30185@sirena.org.uk>
 <4FDEEEBD.5070108@linaro.org>
 <20120618102003.GB12029@n2100.arm.linux.org.uk>
Message-ID: <20120618185638.GY3974@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 11:20:03AM +0100, Russell King - ARM Linux wrote:

> > +	int offset = data->irq;

> Are you sure this is right?  I thought irq_data->irq was the Linux IRQ
> number, irq_data->hwirq was the interrupt number inside the domain.

Yes, that's correct.  I'm surprised the code runs without crashing...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120618/9db19ff6/attachment.sig>
