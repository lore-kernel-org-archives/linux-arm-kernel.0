From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 29 Dec 2012 09:09:55 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <50DE2FFB.8040804@wwwdotorg.org>
References: <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
 <20121217182911.GA10448@obsidianresearch.com>
 <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
 <50CFD0B3.6030208@wwwdotorg.org>
 <20121218025113.GA27029@obsidianresearch.com>
 <50D0A1EA.9090009@wwwdotorg.org>
 <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
 <20121222155040.61829b00@skate>
 <20121228210622.GA4519@avionic-0098.adnet.avionic-design.de>
 <20121228221632.3892e90b@skate> <50DE2FFB.8040804@wwwdotorg.org>
Message-ID: <20121229090955.776816b7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Warren,

On Fri, 28 Dec 2012 16:49:15 -0700, Stephen Warren wrote:

> >> That's great. I've been thinking about this some more and one problem
> >> we'll be facing is that none of the fake host bridges actually exist and
> >> therefore don't have any official PCI IDs. What I did for Tegra was just
> >> choose one of the nForce IDs, but that's obviously hackish. One solution
> >> would be to convince somebody benevolent to sponsor an ID for this
> >> particular purpose. I think Red Hat did so for Virtio.
> > 
> > Indeed, that's a remaining problem to solve. Would be great to have
> > some vendor sponsoring a few IDs for that. At least for a fake PCI Host
> > Bridge and a fake PCI-to-PCI bridge.
> 
> Is it actually necessary for a host/PCI bridge to show up on the PCI bus
> as device 0?

I don't know, PCI experts are much better placed than me to answer this
question. How is this related to the problem of PCI IDs ?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
