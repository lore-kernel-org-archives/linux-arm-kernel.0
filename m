From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 28 Feb 2012 07:20:49 +0000
Subject: [PATCH 0/2 v5] arm: kirkwood: add dreamplug/devicetree support
In-Reply-To: <20120227145724.GU23524@titan.lakedaemon.net>
References: <cover.1312906908.git.jason@lakedaemon.net>
 <cover.1330025976.git.jason@lakedaemon.net>
 <1330254038.10008.24.camel@dagon.hellion.org.uk>
 <20120227145724.GU23524@titan.lakedaemon.net>
Message-ID: <1330413649.10008.50.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-27 at 09:57 -0500, Jason wrote:
> On Sun, Feb 26, 2012 at 11:00:38AM +0000, Ian Campbell wrote:
> > On Thu, 2012-02-23 at 19:52 +0000, Jason Cooper wrote:
> > > This patch series provides initial support for devicetree on kirkwood for the
> > > dreamplug platform.  After discussing the approach with Arnd Bergman last week
> > > at ELC, we decided to take an incremental approach to the conversion.  First, I
> > > would detect that we were on the dreamplug via the devicetree blob.  Then,
> > > configure uart0 via devicetree.  We chose the uart since it is already well
> > > supported under devicetree.
> > > 
> > > This patch series has been boot-tested on the dreamplug.
> > 
> > Tested-by: Ian Campbell <ijc@hellion.org.uk>
> 
> thanks!
> 
> > I needed the following (obvious) patch against u-boot:
> 
> yes, I forgot to mention that.  By any chance, have you tested booting
> non-fdt kernels from u-boot with this option enabled?  I'm fairly sure
> it will work, but I haven't tested it myself.

I hadn't but I have now, it worked fine booting my existing kernel
(which uses v3 of your previous non-FDT dreamplug patches) with the
updated u-boot.

> If you can boot both fdt and non-fdt kernels with this enabled, submit
> it to u-boot, CC: Prafulla, and I'll ack it.

Done.

Thanks,
Ian.
