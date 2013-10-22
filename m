From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Oct 2013 10:05:52 +0100
Subject: [PATCH] typo fixes (coordiante -> coordinate) in am335x
In-Reply-To: <1382198544.22609.8.camel@polaris.local>
References: <1373901928-19605-1-git-send-email-zubair.lutfullah@gmail.com>
 <20130821075828.GZ7656@atomide.com>
 <1382198544.22609.8.camel@polaris.local>
Message-ID: <20131022090552.GE19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Oct 2013, Jan L?bbe wrote:

> On Wed, 2013-08-21 at 00:58 -0700, Tony Lindgren wrote:
> > * Zubair Lutfullah <zubair.lutfullah@gmail.com> [130715 08:33]:
> > > Did a grep for coordiante and replaced them all
> > > with coordinate.
> > > 
> > > This applies to the mfd-next tree.
> > 
> > This should be safe to apply via the MFD tree as a non-critical
> > fix assuming the bootloaders are not yet using this:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> It seems this didn't get applied. It fixes the touchscreen on a
> BeagleBone black with the 7" LCD and we should avoid having people use
> the wrong binding.
> 
> Samuel or Lee: Could you take this patch?

This is the first time this patch has been sent to me.

I need Dmitry's input (no pun intended) on how he's like to deal with
this. At a bare minimum I'd like his Ack.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
