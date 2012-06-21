From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Thu, 21 Jun 2012 12:17:06 +0530
Subject: [PATCH 07/15] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <CACRpkdbi7vmJE9LPmiu2NGM4b_SZ-Hi=a_xgrCOQX9ofKsLFew@mail.gmail.com>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbi7vmJE9LPmiu2NGM4b_SZ-Hi=a_xgrCOQX9ofKsLFew@mail.gmail.com>
Message-ID: <20120621064705.GA24921@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 21:30:17 +0200, Linus Walleij wrote:
> On Wed, Jun 20, 2012 at 2:56 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Here we apply the bindings required for successful Device Tree
> > probing of the i2c-nomadik driver. We also apply a fall-back
> > configuration in case either one is not provided, or a required
> > element is missing from the one supplied.
> >
> > Cc: linux-i2c at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Pls Cc Srinidhi on these patches, and I would prefer to get his ACK on this.

if trivial comments fixed, then

Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

> 
> Srinidhi, could you propose a patch to MAINTAINERS adding yourself as
> explicit maintainer for this driver?

ok.

/srinidhi
