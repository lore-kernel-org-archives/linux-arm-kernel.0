From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 29 Jul 2014 22:48:53 +0200
Subject: [PATCH v2 03/12] ASoC: kirkwood: Remove unused drivers
In-Reply-To: <20140729193509.GK17528@sirena.org.uk>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
 <1405028192-9623-4-git-send-email-andrew@lunn.ch>
 <20140729193509.GK17528@sirena.org.uk>
Message-ID: <20140729204853.GC17763@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 08:35:09PM +0100, Mark Brown wrote:
> On Thu, Jul 10, 2014 at 11:36:23PM +0200, Andrew Lunn wrote:
> > Both kirkwood-openrd and kirkwood-t5325 drivers have been replaced
> > with DT based simple-card equivelents. So remove these drivers.
> 
> Applied.  Please send patches against current code, I needed to hand
> apply this.

Hi Mark

By current do you mean asoc-next? That would not be very easy, since
i'm patching a large number of subsystems here. I don't think the
gpio, or the libata, or the led maintainer would be too happy if i
based the patches on asoc-next! So i picked a plain -rcX kernel,
something neutral to everybody.

	  Andrew
