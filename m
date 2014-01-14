From: tj@kernel.org (Tejun Heo)
Date: Tue, 14 Jan 2014 10:52:08 -0500
Subject: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
In-Reply-To: <20140114154834.GD32507@kw.sim.vm.gnt>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <20140114151404.GN19878@titan.lakedaemon.net>
 <20140114154834.GD32507@kw.sim.vm.gnt>
Message-ID: <20140114155208.GG12131@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 04:48:34PM +0100, Simon Guinot wrote:
> As stable kernel older than 3.10 are no longer maintained, I think
> we don't need to point out a specific commit as a -stable target.
> Simply Cc'ing -stable without any extra informations should be good
> enough.

Well, somebody eventually has to figure it out.  If you know it's
applicable to 3.6+ just do

 Cc: stable at vger.kernel.org # v3.6+

Thanks.

-- 
tejun
