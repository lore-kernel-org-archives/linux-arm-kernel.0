From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 9 May 2012 17:20:54 +0200
Subject: [PATCH 12/15] mfd/db8500-prcmu: Register as a platform driver
 instead of only probing
In-Reply-To: <CACRpkdZB5Hgdb1bGr3uxKYbJgQhatxMR2Pwf7f0NQa7c34gC-Q@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdZB5Hgdb1bGr3uxKYbJgQhatxMR2Pwf7f0NQa7c34gC-Q@mail.gmail.com>
Message-ID: <20120509152054.GM1794@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Apr 24, 2012 at 10:07:41AM +0200, Linus Walleij wrote:
> On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Pass the probe function as part of the platform_driver struct and
> > register using the more common platform_driver_register call. In
> > subsequent patches we'll also add DT support into the struct.
> >
> > CC: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Applied to my for-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
