From: joshc@ni.com (Josh Cartwright)
Date: Thu, 12 Feb 2015 08:31:38 -0600
Subject: [PATCH] ARM: dts: zynq: Add OCM node
In-Reply-To: <20150212102615.GC1245@leverpostej>
References: <135fba212abd740584a2547903cc8d175417344c.1423736523.git.michal.simek@xilinx.com>
 <20150212102615.GC1245@leverpostej>
Message-ID: <20150212143138.GB27577@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 10:26:16AM +0000, Mark Rutland wrote:
> On Thu, Feb 12, 2015 at 10:22:07AM +0000, Michal Simek wrote:
> > Add OCM node for all zynq boards. OCM location
> > can changed but for all current boards this
> > is the location where OCM is.`
> > 
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> > 
> > This patch is done based on discussion here.
> > https://lkml.org/lkml/2014/12/1/396
> > 
> > There are some ways how to do it.
> > OCM location can be changed but board DTS files
> > can easily rewrite it.
> > The problem which there is that node has address
> > in it but maybe someone can suggest better solution.
> 
> Given that the node is so simple, can't this be pushed down into the
> board files? So long as the label is consistent anything else that's
> referring to it should still work.

Not that I have a strong opinion, but I've found that sometimes it's
nice to be able to just glance at the SoC dtsi file to get an
understanding of all of the hardware currently being modeled.

  Josh
