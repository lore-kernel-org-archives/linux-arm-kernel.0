From: sentient@digitalfantasy.co.nz (Sentient)
Date: Wed, 25 Jul 2012 21:40:09 +1200
Subject: [PATCH] ARM: vt8500: clk: Add clock support for arch-vt8500
In-Reply-To: <CAJOA=zNNE18DWwSgfh0H0zGgqpFhPeZrZ8zc0i_cxPBUc2VuoQ@mail.gmail.com>
References: <1342969400-21123-1-git-send-email-linux@prisktech.co.nz>
 <CAJOA=zNNE18DWwSgfh0H0zGgqpFhPeZrZ8zc0i_cxPBUc2VuoQ@mail.gmail.com>
Message-ID: <000001cd6a49$7bb8d500$732a7f00$@digitalfantasy.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Mike,

I might actually have a new patch up by then as the device tree support is coming along nicely.

Regards,
Tony

> -----Original Message-----
> From: vt8500-wm8505-linux-kernel at googlegroups.com [mailto:vt8500-wm8505-linux-kernel at googlegroups.com] On Behalf Of
> Turquette, Mike
> Sent: Wednesday, 25 July 2012 9:08 a.m.
> To: Tony Prisk
> Cc: VT8500 mailing list; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Russell King; Arnd Bergmann; Alexey
> Charkov
> Subject: Re: [PATCH] ARM: vt8500: clk: Add clock support for arch-vt8500
> 
> On Sun, Jul 22, 2012 at 8:03 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> > This patch adds common clock framework support for arch-vt8500.
> > WM8650 support is included in preparation for devicetree support.
> > Each SoC has a seperate initialization function due to no
> > devicetree support to identify SoCs at the moment. Once devicetree
> > is implemented, VT8500 and WM8505 should be combined. WM8650 uses
> > different functions for clocks.
> >
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> 
> Hi Tony,
> 
> I'll give this a more thorough review once the -rc1 window is over.
> 
> Regards,
> Mike
