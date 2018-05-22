From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 May 2018 10:54:31 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add SMP support
In-Reply-To: <ec73ce6d-f062-6c4f-d6fa-b99ef6c6bc67@cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <ec4c6905-23d1-8600-a1cc-4297fbd1ddaa@cogentembedded.com>
 <CAMuHMdU9JXvN2GLFGLZGeNOpZ9AdJYokbpTqt-Wy97-Z0tXaCA@mail.gmail.com>
 <ec73ce6d-f062-6c4f-d6fa-b99ef6c6bc67@cogentembedded.com>
Message-ID: <20180522085430.eqhan4njajnp5hkk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2018 at 08:38:13PM +0300, Sergei Shtylyov wrote:
> On 05/17/2018 11:23 PM, Geert Uytterhoeven wrote:
> 
> >> Add the device nodes for 3 more Cortex-A53 CPU cores; adjust the interrupt
> >> delivery masks for the ARM GIC and Architectured Timer.
> >>
> >> Based on the original (and large) patch by Vladimir Barinov.
> >>
> >> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > Thanks for your patch!
> > 
> >> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> >> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> >> @@ -30,6 +30,36 @@
> >>                         enable-method = "psci";
> >>                 };
> >>
> >> +               a53_1: cpu at 1 {
> >> +                       device_type = "cpu";
> >> +                       compatible = "arm,cortex-a53","arm,armv8";
> > 
> > Please stop copying spaceless lists ;-)
> 
>    Oops! Simon, do I need to re-post?

No, but Geert, are you otherwise ok with this patch?
