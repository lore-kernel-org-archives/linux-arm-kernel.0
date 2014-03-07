From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Mar 2014 19:17:23 +0000
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <CA+gwMcfMMUvRc6ZPh3qM1nGXW3ECWA=CD6M9PbgmoOdwx4fGYQ@mail.gmail.com>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140307175612.GR21483@n2100.arm.linux.org.uk>
 <20140307182857.GB6963@kroah.com>
 <CA+gwMcfMMUvRc6ZPh3qM1nGXW3ECWA=CD6M9PbgmoOdwx4fGYQ@mail.gmail.com>
Message-ID: <20140307191723.GS21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 07:57:51PM +0100, Philipp Zabel wrote:
> [Added Shawn to Cc:]
> 
> On Fri, Mar 7, 2014 at 7:28 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Fri, Mar 07, 2014 at 05:56:12PM +0000, Russell King - ARM Linux wrote:
> >> On Wed, Mar 05, 2014 at 10:20:51AM +0100, Philipp Zabel wrote:
> >> > Hi,
> >> >
> >> > this latest version of the imx-drm DT binding patches applies
> >> > on top of staging-next and also depends on the OF graph binding
> >> > patchset that moves the v4l2_of helpers to drivers/of.
> >> > Currently, the two patchsets are also available at:
> >> >     git://git.pengutronix.de/git/pza/linux.git topic/of-graph
> >> >     git://git.pengutronix.de/git/pza/linux.git topic/imx-drm-dt
> >>
> >> Okay, having looked at the second tree, pulling that will result in
> >> pulling in all of the staging tree here, which I'd rather not do.  Unless
> >> there's any objection, I'd like to take these as patches on top of the
> >> imx-drm stuff which I sent to Greg plus the of-graph stuff which they
> >> depend upon.  In other words, exactly how I've been testing it today.
> >>
> >> Any objections?
> >
> > None from me!  :)
> 
> Nor from me. But I'd like to point out that there already is one merge issue
> with Shawn's for-next branch in arch/arm/boot/dts/imx53-qsb.dts between
>     d5eb195 "ARM: dts: i.MX53: move common QSB nodes to new file"
> and these two patches:
>     17b5001 "imx-drm: convert to componentised device support".
>     "ARM: dts: imx53: Add IPU DI ports and endpoints, move imx-drm node to dtsi"
> The first one already is in staging-next.

Yes, I'm aware of that (since I've been encountering it when creating
the build tree for my autobuilder.)

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
