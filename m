From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Feb 2014 20:50:23 +0000
Subject: [GIT PULL] imx-drm conversion to component support
In-Reply-To: <20140224204141.GA4749@kroah.com>
References: <20140224142019.GA15820@rmk-PC.arm.linux.org.uk>
 <20140224204141.GA4749@kroah.com>
Message-ID: <20140224205023.GQ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 12:41:41PM -0800, Greg KH wrote:
> On Mon, Feb 24, 2014 at 02:20:20PM +0000, Russell King wrote:
> > Greg,
> > 
> > Please incorporate the latest imx-drm updates into staging, which can be
> > found at:
> > 
> >   git://ftp.arm.linux.org.uk/~rmk/linux-arm.git imx-drm-staging
> > 
> > with SHA1 d94905e019acce960feeda1f92a9427fbe45ebbe.
> > 
> > These changes, which convert imx-drm to use the recently merged component
> > infrastructure, have been reviewed and acked by Philipp Zabel, Shawn Guo
> > and Fabio Estevam, and are now deemed to be ready.
> 
> Pulled and pushed out, thanks.

Great, many thanks for that.  This should be a big step forwards for
imx-drm to move out of drivers/staging.

Philipp Zabel is working on some patches which clean up the DT side -
while it's in staging, we can relatively easily change the DT bindings,
but when it moves out, they become more cast in stone.  So, we don't
want to move it out of staging until we have that resolved.

I think we're now very close to it happening though.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
