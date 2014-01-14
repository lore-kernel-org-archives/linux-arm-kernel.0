From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Jan 2014 11:08:00 -0500
Subject: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
In-Reply-To: <20140114155945.GQ19878@titan.lakedaemon.net>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <20140114151404.GN19878@titan.lakedaemon.net>
 <20140114154834.GD32507@kw.sim.vm.gnt>
 <20140114155945.GQ19878@titan.lakedaemon.net>
Message-ID: <20140114160800.GR19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 10:59:45AM -0500, Jason Cooper wrote:
...
> The linux-stable team isn't the only people who find this information
> useful.  Distros maintaining older kernels would find it very helpful
> when going through -stable patches to know easily if a patch should be
> backported further, say to v3.8.

And yes, I'm aware that -stable is actively supporting farther back than
what we are discussing here.  I was refuting the specific argument as
opposed to correcting wrong assumptions.

In general, it's better to be accurate regarding 'Fixes:' commits than
assuming no one cares about anything older than the oldest -stable
kernel.

thx,

Jason.
