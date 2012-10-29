From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 29 Oct 2012 08:27:30 +0000
Subject: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <20121029075003.GA2527@netboy.at.omicron.at>
References: <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at> <50806B1D.9040504@ti.com>
 <20121019061630.GB2983@netboy.at.omicron.at>
 <20121019160041.GB4730@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EB4B4C7@DBDE01.ent.ti.com>
 <20121026180627.GN11908@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EB500C9@DBDE01.ent.ti.com>
 <20121029075003.GA2527@netboy.at.omicron.at>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB5043A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 13:20:03, Richard Cochran wrote:
> On Mon, Oct 29, 2012 at 04:58:23AM +0000, Hiremath, Vaibhav wrote:
> > 
> > Now the expectation has grown to the level where people expect everything in 
> > the Mainline kernel and not in some custom kernel release.
> 
> You are right, except for the "has grown" part. I have always expected
> the official kernel releases to be working and complete, without the
> kind of half baked stumps that the embedded vendors are pushing.
> 
> In my experience with Freescale (and now TI also), the vendor supports
> Linux on their platform by providing a heavily patched, quick and
> dirty, customized kernel that is kinda, sorta working, somehow. This
> provides a way for their customers to get started with the development
> kits right away, and as such I have no problem with it.
> 
> What I do have a problem with is the fact the vendors then drop the
> ball and don't follow through by getting their changes into
> mainline. This makes a huge problem for the vendor's customers later
> on, when the choice becomes either stay with the dead end vendor
> kernel, or try to get mainline working all by themselves.
> 

I completely understand and I can only say that, we have learned our lessons 
long time back on this and we now try to push all our code to Mainline.

Even with TI release kernel we try to stay closer to mainline, so that later
it would be easier to submit the patches to mainline.
For example, in some cases we have back-ported some of the framework changes 
to v3.2 kernel to stay closer to mainline.

 
> And so I am pleased to hear that the Ethernet ports on the am335x will
> be working in v3.8. Better late than never.
> 

Just submitted patches to the list, care to ack them.

Thanks,
Vaibhav 
