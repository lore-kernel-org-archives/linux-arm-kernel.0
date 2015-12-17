From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2015 10:50:20 +0000
Subject: [PATCH 00/10] ARM: debug-ll fixes
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <20151217105020.GH8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 11:30:32PM +0100, Arnd Bergmann wrote:
> Hi everyone,
> 
> I've carried most of these patches for a very long time in
> my randconfig tree, and they follow up on work that Daniel
> Thompson did last year. Most of the changes are really trivial,
> and I'd like to put them into my next/randconfig branch in
> arm-soc for merging in 4.5.

Given the amount of breakage that we're now seeing, I'd say that this
is not true.  I don't believe it's been properly tested: it may have
been tested against some old kernel version, but certainly not against
current kernels.

It's very obvious that it's broken: running 'make defconfig' and then
trying to build the resulting configuration causes errors.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
