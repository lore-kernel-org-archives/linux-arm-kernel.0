From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jun 2016 17:49:44 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <5760346A.10903@arm.com>
References: <20150330140333.GJ24899@n2100.arm.linux.org.uk>
 <55196228.5050805@arm.com>
 <20150330150552.GK24899@n2100.arm.linux.org.uk>
 <55196E31.80803@arm.com> <551AD902.9090401@arm.com>
 <20150402141336.GI24899@n2100.arm.linux.org.uk>
 <551D7EAB.1000200@arm.com> <1465918285.2840.41.camel@linaro.org>
 <20160614155220.GB1041@n2100.armlinux.org.uk>
 <5760346A.10903@arm.com>
Message-ID: <20160614164944.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 05:44:26PM +0100, Sudeep Holla wrote:
> Even with higher latency if the platform is unusable, I agree to remove.
> If you think it's usable with the updated latency(<2 2 1>) then we can
> update it.

The kernels I'm booting have that updated latency.  It used to improve
things, but for most of this year, it fails most boot attempts.  Out
of the last 21 boot attempts, all 21 attempts failed with the above
latency value.

  http://www.armlin ux.org.uk/developer/build/index.php?id=2003

(remove the space...)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
