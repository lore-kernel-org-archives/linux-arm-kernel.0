From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 9 May 2012 17:08:32 +0200
Subject: [PATCH 14/15] mfd/db8500-prcmu: Add Device Tree support and
 enable ux500 platforms
In-Reply-To: <CACRpkdbQpa+YQ6SNytB-aW9Psr8jE1FO-=iyfJsF71RKmzzqUQ@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-15-git-send-email-lee.jones@linaro.org>
 <CACRpkdbQpa+YQ6SNytB-aW9Psr8jE1FO-=iyfJsF71RKmzzqUQ@mail.gmail.com>
Message-ID: <20120509150832.GL1794@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Apr 24, 2012 at 10:18:04AM +0200, Linus Walleij wrote:
> On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Here we see the db8500-prcmu driver obtain DT support. In its
> > current state, all we have to do is offer a matching compatible
> > node and the driver will register and initialise correctly. We
> > Also remove any initialisation completed in platform code to
> > prevent any device duplication.
> >
> > CC: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> OK I need Sam's ACK on this too, then it seems a good idea
> to take all three patches touching the PRCMU driver through the
> ux500-core tree.
I just took 2 of them:

mfd: Enable Device Tree support for the db8500-prcmu
mfd: Add support for db8500-prcmu regulator supply for nmk-i2c.4

Since you have not taken any db8500 patches yet on ux500-core, I can carry
them unless you object to it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
