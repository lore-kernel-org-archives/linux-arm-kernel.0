From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Mar 2013 16:12:37 +0000
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <5146FB70.9000706@openwrt.org>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <514318DE.8060601@openwrt.org>
 <CACmBeS2tbV9Z_c3mCuk4G_+kYpVpVpUKWq3GK=gqBF+ECNhTbg@mail.gmail.com>
 <201303181116.17369.arnd@arndb.de> <5146FB70.9000706@openwrt.org>
Message-ID: <20130318161237.GI4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 12:33:04PM +0100, Florian Fainelli wrote:
> Debian is still kind enough to provide an ARMv4t and higher port  

And I still build some ARMv4 OABI Fedora RPMs myself - but I don't
distribute them because then people expect _me_ do fix their problems
with them.

lists.arm.linux.org.uk / firewall / servers here are all still OABI,
and I don't see any possible upgrade path away from OABI - which is
something I brought up when EABI first reared its ugly head.  Now,
we have N different versions of EABI too.  I'm sure its time we were
discussing NABI - "Next ABI". :)
