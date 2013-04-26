From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Apr 2013 17:07:57 +0200
Subject: [PATCH 01/21] ARM: topology: export cpu_topology
In-Reply-To: <20130426085333.GA30284@mudshark.cambridge.arm.com>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-2-git-send-email-arnd@arndb.de>
 <20130426085333.GA30284@mudshark.cambridge.arm.com>
Message-ID: <201304261707.57328.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 April 2013, Will Deacon wrote:
> On Thu, Apr 25, 2013 at 06:28:44PM +0100, Arnd Bergmann wrote:
> > The cpu_topology symbol is required by any driver using the topology
> > interfaces, which leads to a couple of build errors:
> > 
> > ERROR: "cpu_topology" [drivers/net/ethernet/sfc/sfc.ko] undefined!
> > ERROR: "cpu_topology" [drivers/cpufreq/arm_big_little.ko] undefined!
> 
> Are these first two in mainline?

I think they are both newly added in linux-next.

	Arnd
