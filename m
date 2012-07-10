From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Jul 2012 10:32:03 +0200
Subject: [PATCH v2 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <CAAQ0ZWQg8qX_hySRSfADKgtR1DB5z8+X+kkAQi_dNOEROqX0Ow@mail.gmail.com>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
 <201207100920.03867.marex@denx.de>
 <CAAQ0ZWQg8qX_hySRSfADKgtR1DB5z8+X+kkAQi_dNOEROqX0Ow@mail.gmail.com>
Message-ID: <201207101032.03982.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On 10 July 2012 15:20, Marek Vasut <marex@denx.de> wrote:
> > Dear Shawn Guo,
> > 
> >> From: Marek Vasut <marex@denx.de>
> > 
> > [...]
> > 
> >> +     sound {
> >> +             compatible = "fsl,imx28-evk-sgtl5000",
> > 
> > imx28-evk ? ;-)
> 
> Will fix it, as well as apx4devkit.dts.
> 
> >> +                          "fsl,mxs-audio-sgtl5000";
> >> +             model = "imx28-evk-sgtl5000";
> >> +             saif-controllers = <&saif0 &saif1>;
> >> +             audio-codec = <&sgtl5000>;
> >> +     };
> >> +};
> > 
> > Otherwise, add my Acked-by: Marek Vasut <marex@denx.de> so if it gets
> > broken now, the blame falls on my head ;-)
> 
> I'm much relieved now.

Heh ;-)

> Regards,
> Shawn

Best regards,
Marek Vasut
