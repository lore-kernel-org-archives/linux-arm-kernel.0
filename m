From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 27 Nov 2014 11:24:13 +0000
Subject: [v3, 1/2] arm64: Create link to include/dt-bindings to enable C
 preprocessor use.
In-Reply-To: <5476E215.5020405@samsung.com>
References: <1415727131-4572-2-git-send-email-Liviu.Dudau@arm.com>
 <5476E215.5020405@samsung.com>
Message-ID: <20141127112413.GL828@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 08:34:29AM +0000, Pankaj Dubey wrote:
> Hi Liviu,
> 
> On Tuesday 11 November 2014 11:02 PM, Liviu Dudau wrote:
> > DT files used in the compilation phase can be preprocessed by the C
> > preprocessor. This requires an include/dt-bindings directory to be
> > present in the arch/arm64/boot/dts directory.
> >
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >
> 
> Same change already has been posted as part of adding Exynos7 SoC 
> support, as Exynos7 patches have been accepted in Kukjin's tree, I think 
> following patch [1] as part of Exynos7 series [2] can also be taken.
> 
> 1: http://www.spinics.net/lists/devicetree/msg56552.html
> 2: http://www.spinics.net/lists/devicetree/msg56551.html

Hi Pankaj,

I don't know how Olof and Arnd are going to handle this, but I believe
Arnd has already merged my patchset into the arm-soc tree.

Best regards,
Liviu

> 
> Thanks,
> Pankaj Dubey
> 
> > ---
> > arch/arm64/boot/dts/include/dt-bindings | 1 +
> >   1 file changed, 1 insertion(+)
> >   create mode 120000 arch/arm64/boot/dts/include/dt-bindings
> >
> > \ No newline at end of file
> >
> > diff --git a/arch/arm64/boot/dts/include/dt-bindings b/arch/arm64/boot/dts/include/dt-bindings
> > new file mode 120000
> > index 0000000..08c00e4
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/include/dt-bindings
> > @@ -0,0 +1 @@
> > +../../../../../include/dt-bindings
> >
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
