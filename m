From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Mon, 11 Apr 2016 02:54:31 +0000
Subject: [v7, 0/5] Fix eSDHC host version register bug
In-Reply-To: <CAPDyKFp8GDzSkpbTKoRL=rwiBrsWmsgN95zB-QJwfZTnq4M8BA@mail.gmail.com>
References: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
 <CAPDyKFqgMCvbqMYZ-uM-rTnVvfJkCYbhv2kucCRyNyc9FWoR=Q@mail.gmail.com>
 <HE1PR04MB0889D75DC56E180D3508E7A1F89F0@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <CAPDyKFp8GDzSkpbTKoRL=rwiBrsWmsgN95zB-QJwfZTnq4M8BA@mail.gmail.com>
Message-ID: <HE1PR04MB0889938012DBB9B1F91C6C65F8940@HE1PR04MB0889.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo and Scott,


> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson at linaro.org]
> Sent: Wednesday, April 06, 2016 4:15 PM
> To: Yangbo Lu; Scott Wood
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; linuxppc-dev at lists.ozlabs.org; linux-
> clk at vger.kernel.org; linux-i2c at vger.kernel.org; iommu at lists.linux-
> foundation.org; netdev at vger.kernel.org; linux-mmc; Rob Herring; Russell
> King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh Sharma;
> Zhao Qiang; Kumar Gala; Santosh Shilimkar; Yang-Leo Li; Xiaobo Xie
> Subject: Re: [v7, 0/5] Fix eSDHC host version register bug
> 
> >>
> >> I was about to queue this for next, when I noticed that checkpatch is
> >> complaining/warning lots about these patches. Can you please a round
> >> of checkpatch and fix what makes sense.
> >>
> >> Kind regards
> >> Uffe
> >
> > [Lu Yangbo-B47093] Sorry about this, Uffe...
> 
> No worries!
> 
> > Should I ignore the warnings that update MAINTAINERS?
> 
> drivers/soc/fsl/guts.c isn't part of the MAINTAINERS file, it should be.
> 
> I also realize that the FREESCALE QUICC ENGINE LIBRARY section
> drivers/soc/fsl/qe/* also need an active maintainer, as it's currently
> orphan.
> 
> Perhaps we should have create a new section for drivers/soc/fsl/* instead
> that covers all of the above? Maybe you or Scott are interested to pick
> it up?
> 
> I also noted that, "include/linux/fsl/" isn't present in MAINTAINERS,
> please add that as well.

[Lu Yangbo-B47093] Could give some advice on the MAINTAINERS for these 'fsl' files
since I really don?t know who should be the right person?
I will appreciate that!

Thanks a lot.

> 
> > Regarding the 'undocumented' warning, I will added a patch updates doc
> before all the patches, Ok?
> 
> Yes, good!
> 
> >
> > Thanks a lot :)
> >
> 
> Kind regards
> Uffe
