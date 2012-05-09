From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 12:18:20 +0100
Subject: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
 driver
In-Reply-To: <4FAA46E1.4050708@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
 <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
 <4FAA46E1.4050708@linaro.org>
Message-ID: <20120509111820.GJ3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 11:28:49AM +0100, Lee Jones wrote:

> >Shouldn't this be (av8500->irq_base == NO_IRQ) now that we're tranisitioning to
> >use 0 as NO_IRQ?

> Sure, why not.

I think the endgame is to phase out NO_IRQ entirely...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/cbb73bbc/attachment-0001.sig>
