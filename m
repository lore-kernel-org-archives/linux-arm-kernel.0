From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jul 2017 17:34:27 +0100
Subject: [PATCH 2/4] drm/bridge: dw-hdmi: add cec notifier support
In-Reply-To: <20170724130717.GH31807@n2100.armlinux.org.uk>
References: <20170609133822.GR4902@n2100.armlinux.org.uk>
 <5b2fdadd-f1fa-c454-b3fe-facf221beb78@baylibre.com>
 <20170609141056.GS4902@n2100.armlinux.org.uk>
 <b46f25c1-45fd-2917-6559-218f6887a882@xs4all.nl>
 <20170717090516.GJ31807@n2100.armlinux.org.uk>
 <e80b0213-7632-faf4-5d57-06509912990d@xs4all.nl>
 <20170717120513.GK31807@n2100.armlinux.org.uk>
 <35c2af77-b717-b86a-1f19-b3571d2fe156@xs4all.nl>
 <fba25a7e-671a-f7f4-93d6-68b004191675@xs4all.nl>
 <20170724130717.GH31807@n2100.armlinux.org.uk>
Message-ID: <20170724163427.GI31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 02:07:17PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 24, 2017 at 02:16:40PM +0200, Hans Verkuil wrote:
> > Just to make sure you aren't waiting for me to do anything: as far as I can tell
> > the Kconfig above will ensure the right dependencies. If you have an example
> > where this fails, then let me know. I am not planning on making any changes.
> > Frankly, I wouldn't know what to change since AFAICT it is all working with
> > the above Kconfig.
> 
> No, I just haven't got around to it yet - I've been busy all last week
> trying to work out what's been causing a USB host driver to fail for a 
> client, and as such haven't had any chance to look at much else post
> merge window yet.

It's going to be a while yet - today I've attempted to bring my tree
forward to v4.13-rc2, but it's proven a long and difficult task to get
anywhere close to finishing that... and I've just ended up rewinding
back to this morning's state (because I ended up having to drop some
branches that other stuff depended upon.)

I'll have another go later in the week.

Until I can do this, I can't do anything else with mainline work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
