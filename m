From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 25 Aug 2014 19:19:30 +0800
Subject: [PATCH 0/6] SolidRun Hummingboard/Cubox-i DT updates
In-Reply-To: <20140825095106.GS30401@n2100.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <20140825062930.GA6928@dragon>
 <20140825095106.GS30401@n2100.arm.linux.org.uk>
Message-ID: <20140825111929.GC6928@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 10:51:07AM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 25, 2014 at 02:29:32PM +0800, Shawn Guo wrote:
> > On Sat, Aug 23, 2014 at 10:10:58AM +0100, Russell King - ARM Linux wrote:
> > > Here's a set of patches updating the Cubox-i/Hummingboard DT files.
> > > 
> > > The first two are fairly important fixes, so should at least go in
> > > for -rc kernels.
> > > 
> > > The SPDIF patch is something which could go in -rc as well as it's a
> > > cosmetic patch, changing the name displayed in (eg) pulseaudio for the
> > > SPDIF output from the developer-centric "imx-spdif" to "Integrated SPDIF".
> > 
> > I will sent the first 3 for -rc.  But I second Iain's comment that the
> > first patch should have a better commit log to explain why it's an
> > important fix.
> 
> I still have no answer for that, so I suggest dropping it until Rabeeh
> can write a better commit log.

Okay.  #2 and #3 applied on imx/fixes, and #4~6 applied on imx/dt.

Shawn
