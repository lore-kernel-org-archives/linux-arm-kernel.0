From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 13 Jul 2015 11:34:57 +0800
Subject: [PATCH v3 5/5] arm64: dts: mt8173: Add subsystem clock
 controller device nodes
In-Reply-To: <CAGS+omC7274iPDdfXpKuM0HvCcEscUE5e5jrDH4DhW4j_Ykt2A@mail.gmail.com>
References: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
 <1436522405-13923-6-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omC7274iPDdfXpKuM0HvCcEscUE5e5jrDH4DhW4j_Ykt2A@mail.gmail.com>
Message-ID: <1436758497.9416.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 2015-07-10 at 23:02 +0800, Daniel Kurtz wrote:
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index a2f63e4..9d74ce5 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -227,6 +227,36 @@
> >                         clocks = <&uart_clk>;
> >                         status = "disabled";
> >                 };
> > +
> > +               mmsys: mmsys at 14000000 {
> 
> I think we agreed previously that these should all be
> clock-controller at .
> 
You're right. I'll change it in next patch.


Best regards,

James
