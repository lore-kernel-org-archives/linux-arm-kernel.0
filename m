From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Apr 2013 15:47:45 +0800
Subject: MicroSys sbc6x support (i.MX6)
In-Reply-To: <20130401094358.4c313f66@crub>
References: <20130329185500.GB30029@amd.pavel.ucw.cz>
 <20130330113703.GA21042@amd.pavel.ucw.cz>
 <5156D69E.3050600@gmail.com>
 <20130331201614.GC25751@amd.pavel.ucw.cz>
 <20130401064224.GD1693@S2101-09.ap.freescale.net>
 <20130401094358.4c313f66@crub>
Message-ID: <20130401074743.GC27148@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 01, 2013 at 09:43:58AM +0200, Anatolij Gustschin wrote:
> On Mon, 1 Apr 2013 14:42:25 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> ...
> > > +/dts-v1/;
> > > +/include/ "imx6q.dtsi"
> > > +
> > > +/ {
> > > +	model = "MicroSys sbc6x board";
> > > +	compatible = "fsl,imx6q";
> > 
> > We generally have a vendor specific compatible string for custom
> > boards. 
> 
> Couldn't this be a compatible list like
> 
>     compatible = "microsys,sbc6x", "fsl,imx6q";
> 
Yes, this is what I was asking for and every imx board dts file is
doing.  Sorry if I did not make it clear.

Shawn

> Then, we can test for imx6q compatibility in drivers or
> platform code using of_machine_is_compatible(). Or what is the
> preferred way to test for SoC compatibility?
> 
> Thanks,
> 
> Anatolij
