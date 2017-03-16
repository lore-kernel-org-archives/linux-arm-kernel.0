From: phdm@macq.eu (Philippe De Muyter)
Date: Thu, 16 Mar 2017 10:47:29 +0100
Subject: media / v4l2-mc: wishlist for complex cameras (was Re: [PATCH
 v4 14/36] [media] v4l2-mc: add a function to inherit controls from
 a pipeline)
In-Reply-To: <1489656360.2303.2.camel@pengutronix.de>
References: <20170311082549.576531d0@vento.lan>
 <20170313124621.GA10701@valkosipuli.retiisi.org.uk>
 <20170314004533.3b3cd44b@vento.lan>
 <e0a6c60b-1735-de0b-21f4-d8c3f4b3f10f@xs4all.nl>
 <20170314072143.498cde9b@vento.lan> <20170314223254.GA7141@amd>
 <20170314215420.6fc63c67@vento.lan> <20170315105049.GA12099@frolo.macqel>
 <1489604109.4593.4.camel@ndufresne.ca>
 <1489656360.2303.2.camel@pengutronix.de>
Message-ID: <20170316094729.GA5595@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 10:26:00AM +0100, Philipp Zabel wrote:
> On Wed, 2017-03-15 at 14:55 -0400, Nicolas Dufresne wrote:
> > Le mercredi 15 mars 2017 ? 11:50 +0100, Philippe De Muyter a ?crit :
> > > > I would say: camorama, xawtv3, zbar, google talk, skype. If it runs
> > > > with those, it will likely run with any other application.
> > > > 
> > > 
> > > I would like to add the 'v4l2src' plugin of gstreamer, and on the
> > > imx6 its
> > 
> > While it would be nice if somehow you would get v4l2src to work (in
> > some legacy/emulation mode through libv4l2),
> 
> v4l2src works just fine, provided the pipeline is configured manually in
> advance via media-ctl.

Including choosing the framerate ?  Sorry, I have no time these days
to test it myself.

And I cited imxv4l2videosrc for its ability to provide the physical address
of the image buffers for further processing by other (not necessarily next
in gstreamer pipeline, or for all frames) hardware-accelerated plugins likes
the h.264 video encoder.  As I am stuck with fsl/nxp kernel and driver on that
matter, I don't know how the interfaces have evolved in current linux kernels.

BR

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
