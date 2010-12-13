From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 13 Dec 2010 21:55:30 +0900
Subject: [PATCH] ARM: Allow machine to specify it's own IRQ handlers at
	run-time
In-Reply-To: <AANLkTimnQgW2K+n4Ttgi=jzkh0xXSkgA5B5bj7ZYGwKc@mail.gmail.com>
References: <AANLkTi=Unb_08zF8jStBJvbFeo01QprPt=ag0CrE1oLB@mail.gmail.com>
	<20101205092345.GA9138@n2100.arm.linux.org.uk>
	<AANLkTimbFYCxcSU0+c2Q2D2yQ1wRPMmTx1Pdtu3CvM4m@mail.gmail.com>
	<20101206080606.GA29563@n2100.arm.linux.org.uk>
	<AANLkTi=5sMZUwu+yhha=CugFwrhqTwYSTvKOHEbu8RE3@mail.gmail.com>
	<20101206101100.GB29563@n2100.arm.linux.org.uk>
	<AANLkTinuQWszBuA01zDkXBM5gWOsxYufWQFyqYQmOcbP@mail.gmail.com>
	<20101208134140.GB9777@n2100.arm.linux.org.uk>
	<AANLkTinWANEgSqioEUtR6UcwD7JK1hpXuspKQGqEctko@mail.gmail.com>
	<20101212144934.GI8665@n2100.arm.linux.org.uk>
	<AANLkTincg=mOt+5sHSDU-Oiz_ETpoCg010fO52QNNZRM@mail.gmail.com>
	<AANLkTimnQgW2K+n4Ttgi=jzkh0xXSkgA5B5bj7ZYGwKc@mail.gmail.com>
Message-ID: <AANLkTim9bvBpPatFvvO_fmqdyOrvVNvc45SW5V1ZA7=z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Mon, Dec 13, 2010 at 5:45 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Hi Russell,
>
> I've submitted the patch to your patch tracking system with the line
> below:
>
> The assembly code to invoke handle_arch_irq is optimized by Russell
> King.
>
> Shame that it now looks I did almost nothing to this patch :-)

Thanks for your work on this. I've tried out your patch on real
hardware today and it works well. Sorry for not giving you more
feedback earlier. No need to rip the patch out of the tracker or
anything, but feel free to add my acked-by if you happen to resubmit
in the future.

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
