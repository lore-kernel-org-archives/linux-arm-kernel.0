From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 12 Apr 2016 12:31:45 +0200
Subject: [PATCH v5 30/46] regulator: pwm: retrieve correct voltage
In-Reply-To: <20160412100938.GA14664@sirena.org.uk>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-31-git-send-email-boris.brezillon@free-electrons.com>
 <20160330212410.GX2350@sirena.org.uk>
 <20160407235431.788dc24a@bbrezillon>
 <20160412044203.GW3351@sirena.org.uk>
 <20160412103722.0bfe1d4d@bbrezillon>
 <20160412100938.GA14664@sirena.org.uk>
Message-ID: <20160412123145.092b2c1e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016 11:09:38 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Apr 12, 2016 at 10:37:22AM +0200, Boris Brezillon wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Apr 07, 2016 at 11:54:31PM +0200, Boris Brezillon wrote:
> 
> > > I'm not sure there's a strong one, we don't really use the class device
> > > for anything, but without doing a full audit I couldn't guarantee that.
> 
> > At first glance I don't see any problem (even the rdev_err/info/...()
> > functions do not use dev_err/info/...()). The patch will be part of v6
> > (unless you want me to send it independently).
> 
> I'd rather it didn't get sucked into this series since it seems that
> it's getting delayed indefinitely - I can apply it to the regulator tree
> and create a tag that can be pulled into other trees as needed if things
> do get applied.

Done.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
