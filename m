From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Mar 2015 10:32:44 -0700
Subject: [PATCH 3/3] ARM: omap2plus_defconfig: Enable n900 modem as
 loadable modules
In-Reply-To: <20150317110000.GA1115@earth>
References: <1426536003-7077-1-git-send-email-tony@atomide.com>
 <1426536003-7077-4-git-send-email-tony@atomide.com>
 <20150317110000.GA1115@earth>
Message-ID: <20150317173243.GF31346@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [150317 04:00]:
> Hi Tony,
> 
> On Mon, Mar 16, 2015 at 01:00:03PM -0700, Tony Lindgren wrote:
> > Enable n900 modem as loadable modules.
> 
> Acked-By: Sebastian Reichel <sre@kernel.org>
> 
> > [...]
> > +CONFIG_HSI_CHAR=m
> > [...]
> 
> I think this one should be disabled by default. It's only needed by
> very few people (it exposes the hsi bus to userspace, like i2c-dev
> driver does for i2c).

OK will disable thanks.

Tony
