From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Mar 2014 09:30:35 +0000
Subject: [PATCH 07/12] drm: drm_display_mode: add signal polarity flags
In-Reply-To: <20140318085030.66db84b7@ipc1.ka-ro>
References: <1394731053-6118-1-git-send-email-denis@eukrea.com>
 <2166863.3Fn4k2rvaz@avalon> <20140317161436.06169b33@ipc1.ka-ro>
 <2777667.XJdaUSpRsD@avalon> <20140318085030.66db84b7@ipc1.ka-ro>
Message-ID: <20140318093035.GR21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 08:50:30AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Laurent Pinchart wrote:
> > Hi Lothar,
> > 
> > On Monday 17 March 2014 16:14:36 Lothar Wa?mann wrote:
> > > DE is not a clock signal, but an 'Enable' signal whose value (high or
> > > low) defines the window in which the pixel data is valid.
> > > The flag defines whether data is valid during the HIGH or LOW period of
> > > DE.
> > 
> > The DRM_MODE_FLAG_POL_DE_(LOW|HIGH) do, by my impression of the proposed new 
> > DRM_MODE_FLAG_POL_DE_*EDGE flags is that they define sampling clock edges, not 
> > active levels.
> > 
> The current naming of the flags gives the impression that they describe
> the sampling edges of a clock signal. But the DE signal in fact is not
> a clock signal but a level sensitive gating signal.

+1

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
