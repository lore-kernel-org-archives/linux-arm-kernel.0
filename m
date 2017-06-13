From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 Jun 2017 13:25:47 +0200
Subject: [PATCH 3/4] arm64: dts: marvell: Enable second SDHCI controller
 in Armada 37xx
In-Reply-To: <87tw3k8aga.fsf@free-electrons.com>
References: <20170608165125.27630-1-gregory.clement@free-electrons.com>
 <20170608165125.27630-4-gregory.clement@free-electrons.com>
 <20170608211702.27a7b560@free-electrons.com>
 <87tw3k8aga.fsf@free-electrons.com>
Message-ID: <20170613132547.5176af18@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 13 Jun 2017 12:10:29 +0200, Gregory CLEMENT wrote:

> >> +				reg = <0xd0000 0x300
> >> +				       0x1e808 0x4>;  
> >
> > I'd prefer:
> >
> > 				reg = <0xd0000 0x300>, <0x1e808 0x4>;  
> 
> For this one I think it is a matter of taste. I had a look on the other
> files and it seems more common to put them on multi lines that on one
> single line. And personally I prefer it, for me it seems more visible
> that we use 2 set of registers.

I'm not talking about multiple lines vs. one line. I'm talking about:

	reg = <X Y
	       A B>;

vs.

	reg = <X Y>,
	      <A B>;

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
