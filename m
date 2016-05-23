From: carlo@caione.org (Carlo Caione)
Date: Mon, 23 May 2016 13:16:19 +0200
Subject: [RFC PATCH] soc: Amlogic: Add secure monitor driver
In-Reply-To: <5742E4FF.7030504@gmail.com>
References: <1463335845-23534-1-git-send-email-carlo@caione.org>
 <20160516113333.GG656@leverpostej>
 <CAOQ7t2aCccyqtzQGQ0q+Q4+toAwrVVVLG5=idgZ1eGOLyJMY2g@mail.gmail.com>
 <5742E4FF.7030504@gmail.com>
Message-ID: <20160523111619.GB17269@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/16 13:09, Matthias Brugger wrote:
 
[...]
> >>>diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> >>>index 76b3b6d..e4017c3 100644
> >>>--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> >>>+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> >>>@@ -98,6 +98,10 @@
> >>>               method = "smc";
> >>>       };
> >>>
> >>>+     sm {
> >>>+             compatible = "amlogic,meson-sm";
> >>>+     };
> >>
> >>We should have more specific strings, at least in addition to this.
> >
> >Agree, not sure what I can add though.
> 
> I would say someting linke "amlogic,gxbb-sm" to specify the SoC.

If you look at v2 of this patchset [1] I separated the SoC specific
SMC32 function definitions in a separate header file so I think the main
driver is generic enough to be called meson-sm.

Cheers,

[1] http://www.spinics.net/lists/arm-kernel/msg505087.html

-- 
Carlo Caione
