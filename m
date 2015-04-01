From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Apr 2015 12:56:03 +0100
Subject: [PATCH RFC 07/11] drm/edid: add function to help find SADs
In-Reply-To: <87wq1wrrxn.fsf@intel.com>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfY0-0002vI-0F@rmk-PC.arm.linux.org.uk>
 <87wq1wrrxn.fsf@intel.com>
Message-ID: <20150401115602.GB24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 02:47:32PM +0300, Jani Nikula wrote:
> On Mon, 30 Mar 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > Add a function to find the start of the SADs in the ELD.  This
> > complements the helper to retrieve the SAD count.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I guess version 31 is specific enough to warrant a #define of its own,
> but meh.

What about version 2?  We don't have any version definitions in
drm_edid.h at all.  It would be nice to see some...

It would also be nice to see some of this stuff not being DRM specific,
because EDID parsing isn't something limited to DRM - and let's face it,
one of the biggest consumers of graphics on Linux is Android, which I'm
told is pretty much wedded to the fbdev API.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
