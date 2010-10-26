From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Tue, 26 Oct 2010 12:43:55 -0500
Subject: [PATCH v2 0/4] tidspbridge: SCM layer violation fixes
In-Reply-To: <AANLkTik2K+q-585Ap2QFTaOT+vGnz1+14R5ZeenV-2J0@mail.gmail.com>
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
	<AANLkTik2K+q-585Ap2QFTaOT+vGnz1+14R5ZeenV-2J0@mail.gmail.com>
Message-ID: <AANLkTi=ZUPFqrTeLhuDKzkgU19RyMPD5DJ8kdJCyOXZz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 12:13 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>> ?arch/arm/plat-omap/include/plat/iva2_dsp.h ? ?| ? 56 +++++++++++++++++++++++++
>
> Why not use the already existing dsp.h?

Good point, I guess when the patch was made dsp.h didn't exist, but
since the user of those defines is pm34xx.c too, including it in dsp.h
would include the declaration of everything inside dsp.h; however I
don't see that as an impediment for dma.h or gpmc.h to be included.

Regards,
Omar
