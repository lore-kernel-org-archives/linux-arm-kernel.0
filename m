From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Sat, 19 Oct 2013 18:02:24 +0200
Subject: [PATCH] typo fixes (coordiante -> coordinate) in am335x
In-Reply-To: <20130821075828.GZ7656@atomide.com>
References: <1373901928-19605-1-git-send-email-zubair.lutfullah@gmail.com>
 <20130821075828.GZ7656@atomide.com>
Message-ID: <1382198544.22609.8.camel@polaris.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-21 at 00:58 -0700, Tony Lindgren wrote:
> * Zubair Lutfullah <zubair.lutfullah@gmail.com> [130715 08:33]:
> > Did a grep for coordiante and replaced them all
> > with coordinate.
> > 
> > This applies to the mfd-next tree.
> 
> This should be safe to apply via the MFD tree as a non-critical
> fix assuming the bootloaders are not yet using this:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

It seems this didn't get applied. It fixes the touchscreen on a
BeagleBone black with the 7" LCD and we should avoid having people use
the wrong binding.

Samuel or Lee: Could you take this patch?

Thanks,
Jan L?bbe
