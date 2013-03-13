From: anilkumar.v@ti.com (Kumar, Anil)
Date: Wed, 13 Mar 2013 02:59:59 +0000
Subject: [PATCH 4/9] ARM: dts: OMAP3: Add support for OMAP3430 SDP board
In-Reply-To: <513F9DA8.4090200@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
 <1362763654-9660-5-git-send-email-jon-hunter@ti.com>
 <CABYxbz7Bg3Uf2wkhH=4d6nEPUjyHF8BiixN6rGCOgEVG_us8Jw@mail.gmail.com>
 <513E1A1C.8070206@ti.com>
 <F3DBB1B3EF102E4994C89758CFCA32412CE371@DBDE01.ent.ti.com>
 <513F9DA8.4090200@ti.com>
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412CE851@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 02:57:04, Hunter, Jon wrote:
> 
> On 03/11/2013 09:42 PM, Kumar, Anil wrote:
> > 
> > On Mon, Mar 11, 2013 at 23:23:32, Hunter, Jon wrote:
> >>
> >> On 03/08/2013 08:25 PM, Anil Kumar wrote:
> >>> Hi Jon,
> >>>
> >>> On Fri, Mar 8, 2013 at 10:57 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> >>>> Adds basic device-tree support for OMAP3430 SDP board which has 256MB
> >>>> of RAM and uses the TWL4030 power management IC.
> >>>
> >>> I think this board support should be in separate patch series with
> >>> related patches.
> >>
> >> Well I wanted to keep them altogether so that I can send a pull request
> >> to Benoit and Tony.
> > 
> > Sorry, but can you please tell what makes you to think that you
> > can send pull request only when they are altogether ?
> 
> That's not the point.
>  
> > Is there any logical dependency with other patches except 
> > "[PATCH 6/9] ARM: dts: Add OMAP3430 SDP flash memory bindings" is on 
> > top of this patch ?
> 
> Per the $subject of the series these a various DT patches I have pending.
> Yes I could break this series up into many separate series, one for PMU,
> one for DMA, one for GPMC, one for OMAP3 SDP, but I thought it would be
> easier for Tony and Benoit to pull as a single series.

I am really Sorry, If I said any nonsense here. I did not know that 
we can do like that also.

Thanks,
Anil
