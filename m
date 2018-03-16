From: harald@ccbib.org (Harald Geyer)
Date: Fri, 16 Mar 2018 10:30:55 +0100
Subject: arm64: allwinner: Add support for TERES I laptop
In-Reply-To: <20180315170606.GA3635@afzalpc>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180315170606.GA3635@afzalpc>
Message-ID: <E1ewlhQ-0000Jx-6s@stardust.g4.wien.funkfeuer.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

afzal mohammed writes:
> On Mon, Mar 12, 2018 at 04:10:45PM +0000, Harald Geyer wrote:
> > This series adds support for the TERES I open hardware laptop produced
> > by olimex. With these patches and a bootloader capable of setting up
> > simple framebuffer the laptop is quite useable.
> 
> Thanks for the patches
> 
> w/ defconfig could reach to prompt via serial console using audio
> jack.
> 
> And just by enabling PWM_SUN4I & FB_SIMPLE, laptop could function
> standalone as well.
> 
> Suggestions (feel free to ignore):
> 
> 1. seems currently only review comment pending is on simple
> framebuffer, perhaps you can proceed removing just that so that a
> basic bootable system can be achieved at the earliest (iiuc, anyway
> drm would be the final solution for display)

I'm under the impression that I addressed the concerns regarding simplefb
satisfactorily. But yes: I hope to get this merged in time for 4.17.
If simplefb is a problem for that, I'd rather drop it then postpone
the entire series.

Thanks for testing,
Harald
