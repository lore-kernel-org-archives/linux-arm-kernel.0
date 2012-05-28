From: marex@denx.de (Marek Vasut)
Date: Mon, 28 May 2012 18:28:42 +0200
Subject: [PATCH] MXS: Add DENX M28 dts file
In-Reply-To: <CAOMZO5C-XbGqWHxpX24V6X58rcnSeSobuyJNiZTJErQi55tEbQ@mail.gmail.com>
References: <1338084735-12083-1-git-send-email-marex@denx.de>
 <CAOMZO5C-XbGqWHxpX24V6X58rcnSeSobuyJNiZTJErQi55tEbQ@mail.gmail.com>
Message-ID: <201205281828.43129.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Hi Marek,
> 
> On Sat, May 26, 2012 at 11:12 PM, Marek Vasut <marex@denx.de> wrote:
> > +       sound {
> > +               compatible = "fsl,imx28-evk-sgtl5000",
> > +                            "fsl,mxs-audio-sgtl5000";
> > +               model = "imx28-evk-sgtl5000";
> > +               saif-controllers = <&saif0 &saif1>;
> > +               audio-codec = <&sgtl5000>;
> > +       };
> > +};
> 
> Shouldn't this be:

it should ... you know the drill, s/xxx/yyy/g ;-)

btw the way I set up GPIOs is correct? I'm quite unsure about it, can you please 
verify?

Thanks!

> 
> sound {
> 	compatible = "fsl,imx28-m28-sgtl5000",
> 		     "fsl,mxs-audio-sgtl5000";
> 	model = "imx28-m28-sgtl5000";
> 	saif-controllers = <&saif0 &saif1>;
> 	audio-codec = <&sgtl5000>;
> };

Best regards,
Marek Vasut
