From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Jun 2012 13:54:00 +0800
Subject: [PATCH] MXS: Add DENX M28 dts file
In-Reply-To: <CAOMZO5C-XbGqWHxpX24V6X58rcnSeSobuyJNiZTJErQi55tEbQ@mail.gmail.com>
References: <1338084735-12083-1-git-send-email-marex@denx.de>
 <CAOMZO5C-XbGqWHxpX24V6X58rcnSeSobuyJNiZTJErQi55tEbQ@mail.gmail.com>
Message-ID: <20120606055357.GF2667@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 12:27:29PM -0300, Fabio Estevam wrote:
> Hi Marek,
> 
> On Sat, May 26, 2012 at 11:12 PM, Marek Vasut <marex@denx.de> wrote:
> 
> > + ? ? ? sound {
> > + ? ? ? ? ? ? ? compatible = "fsl,imx28-evk-sgtl5000",
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ?"fsl,mxs-audio-sgtl5000";
> > + ? ? ? ? ? ? ? model = "imx28-evk-sgtl5000";
> > + ? ? ? ? ? ? ? saif-controllers = <&saif0 &saif1>;
> > + ? ? ? ? ? ? ? audio-codec = <&sgtl5000>;
> > + ? ? ? };
> > +};
> 
> Shouldn't this be:
> 
> sound {
> 	compatible = "fsl,imx28-m28-sgtl5000",
> 		     "fsl,mxs-audio-sgtl5000";
> 	model = "imx28-m28-sgtl5000";
> 	saif-controllers = <&saif0 &saif1>;
> 	audio-codec = <&sgtl5000>;
> };

Yes, this one looks sane to me.

-- 
Regards,
Shawn
