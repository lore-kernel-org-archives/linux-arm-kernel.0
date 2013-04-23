From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Apr 2013 16:09:59 +0100
Subject: [PATCH] ARM: ux500: Over-ride TCDM size when booting the DB8540
 platform
In-Reply-To: <CACRpkdYLJyvCK33pAHeOkXfBOiPJGAZ9bV+s-cJanfOXz+VTOg@mail.gmail.com>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdbh-DJti2ny=uBe-b_vGkQBNL=emMuZ6+_cE5jvRsA4sA@mail.gmail.com>
 <20130404073340.GA6892@gmail.com>
 <CACRpkdYLJyvCK33pAHeOkXfBOiPJGAZ9bV+s-cJanfOXz+VTOg@mail.gmail.com>
Message-ID: <20130423150959.GA17416@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Apr 2013, Linus Walleij wrote:

> On Thu, Apr 4, 2013 at 9:33 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > The PRCMU's Tightly Coupled Data Memory on the DB8540 platform is
> > 8kB larger than it's predecessor's. We need to reflect that in its
> > Device Tree. By re-specifying the address and size of the device
> > we effectively over-ride the previous values with more accurate
> > ones.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> As mentioned this patch does not apply. Some whitespace trouble.
> 
> And please squash it into the patch adding the ccu8540, 3/9.

I'm not sure what's going on with all this whitespace stuff, my branch
looks fine. Any chance I can just supply you with a branch to take
instead?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
