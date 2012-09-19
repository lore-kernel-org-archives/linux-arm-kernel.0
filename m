From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 19 Sep 2012 09:05:23 +0100
Subject: [PATCH 6/6] staging: drm/imx: Add TODO
In-Reply-To: <20120919071803.GW6180@pengutronix.de>
References: <1347445874-10779-1-git-send-email-s.hauer@pengutronix.de>
 <1347445874-10779-7-git-send-email-s.hauer@pengutronix.de>
 <20120919055322.GI6460@S2100-06.ap.freescale.net>
 <20120919071803.GW6180@pengutronix.de>
Message-ID: <20120919080523.GB18986@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 09:18:03AM +0200, Sascha Hauer wrote:
> On Wed, Sep 19, 2012 at 01:53:25PM +0800, Shawn Guo wrote:
> > On Wed, Sep 12, 2012 at 12:31:14PM +0200, Sascha Hauer wrote:
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/staging/imx-drm/TODO |   22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >  create mode 100644 drivers/staging/imx-drm/TODO
> > > 
> > > diff --git a/drivers/staging/imx-drm/TODO b/drivers/staging/imx-drm/TODO
> > > new file mode 100644
> > > index 0000000..2075646
> > > --- /dev/null
> > > +++ b/drivers/staging/imx-drm/TODO
> > > @@ -0,0 +1,22 @@
> > > +TODO:
> > > +- get DRM Maintainer review for this code
> > > +- Factor out more code to common helper functions
> > > +- decide where to put the base driver. It is not specific to a subsystem
> > > +  and would be used by DRM/KMS and media/V4L2
> > > +- convert irq driver to irq_domain_add_linear
> > > +
> > > +Missing features (not necessarily for moving out out staging):
> > 
> > out of?
> 
> Will fix.
> 
> > 
> > > +
> > > +- Add KMS plane support for CRTC driver
> > > +- Add LDB (LVDS Display Bridge) support
> > > +- Add i.MX6 HDMI support
> > > +- Add support for IC (Image converter)
> > > +- Add support for CSI (CMOS Sensor interface)
> > > +- Add support for VDIC (Video Deinterlacer)
> > > +
> > > +Many work-in-progress patches for the above features exist. Contact
> > > +Sascha Hauer <kernel@pengutronix.de> if you are interested in working
> > > +on a specific feature.
> > > +
> > > +Please send any patches to Greg Kroah-Hartman <greg@kroah.com> and
> > 
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>?
> 
> Hm, right. I copied this from another TODO file.
> 
> # find drivers/staging/ -name TODO | xargs grep greg at kroah.com | wc -l
> 20
> 
> Maybe Gregs address should be dropped here, he will show up in
> get-maintainers.pl anyway.
> 
> Greg?

Both end up in the same place, so it's not a big deal to leave my
kroah.com address in there, but for new files, use linuxfoundation.org
please.

thanks,

greg k-h
