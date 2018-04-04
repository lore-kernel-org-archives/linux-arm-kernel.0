From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Wed, 4 Apr 2018 15:49:16 +0200
Subject: [PATCH v5 01/13] ARM: move cputype definitions into another file
In-Reply-To: <4ba0f1c4-a52a-b9f5-67ac-bf348a13228a@gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-2-mylene.josserand@bootlin.com>
 <CAGb2v64GL=1UcYs1tFp-mS07vbHBao82SEhyzUrUHB++2-EKBg@mail.gmail.com>
 <4ba0f1c4-a52a-b9f5-67ac-bf348a13228a@gmail.com>
Message-ID: <20180404154916.66870e98@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Florian,

On Tue, 3 Apr 2018 12:56:30 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 04/02/2018 11:52 PM, Chen-Yu Tsai wrote:
> > On Tue, Apr 3, 2018 at 2:18 PM, Myl?ne Josserand
> > <mylene.josserand@bootlin.com> wrote:  
> >> To add the support for SMP on sun8i-a83t, we will use some
> >> definitions in an assembly file so move definitions into
> >> another file to separate C functions and macro defintions.  
> > 
> > Instead of moving the definitions, you could guard all the C
> > stuff in "#ifndef __ASSEMBLY__". AFAIK a few header files do that.  
> 
> Which is effectively what this patch does (still waiting for an ACK):
> 
> https://patchwork.kernel.org/patch/10239855/

Thanks for pointing out this existing patch.
I will use it for my next series and add my Tested-by (once tested, of
course).

Best regards,

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

> 
> > 
> > ChenYu
> >   
> >> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> >> ---
> >>  arch/arm/include/asm/cputype.h     | 94 +-----------------------------------
> >>  arch/arm/include/asm/cputype_def.h | 98 ++++++++++++++++++++++++++++++++++++++  
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >   
> 
> 
