From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 7 Mar 2014 10:28:57 -0800
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <20140307175612.GR21483@n2100.arm.linux.org.uk>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140307175612.GR21483@n2100.arm.linux.org.uk>
Message-ID: <20140307182857.GB6963@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 05:56:12PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 05, 2014 at 10:20:51AM +0100, Philipp Zabel wrote:
> > Hi,
> > 
> > this latest version of the imx-drm DT binding patches applies
> > on top of staging-next and also depends on the OF graph binding
> > patchset that moves the v4l2_of helpers to drivers/of.
> > Currently, the two patchsets are also available at:
> >     git://git.pengutronix.de/git/pza/linux.git topic/of-graph
> >     git://git.pengutronix.de/git/pza/linux.git topic/imx-drm-dt
> 
> Okay, having looked at the second tree, pulling that will result in
> pulling in all of the staging tree here, which I'd rather not do.  Unless
> there's any objection, I'd like to take these as patches on top of the
> imx-drm stuff which I sent to Greg plus the of-graph stuff which they
> depend upon.  In other words, exactly how I've been testing it today.
> 
> Any objections?

None from me!  :)
