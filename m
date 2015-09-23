From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Sep 2015 10:13:42 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56026795.3090403@free.fr>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
 <5601799C.20701@free.fr>
 <20150922162947.GC21084@n2100.arm.linux.org.uk>
 <56026795.3090403@free.fr>
Message-ID: <20150923091342.GH21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 10:49:25AM +0200, Mason wrote:
> In my platform Kconfig, something along the lines of
> 
> config ARM_L1_CACHE_SHIFT
> 	int
> 	default 5 if !ARCH_MULTIPLATFORM

How would that be useful to you?  Arnd is saying that you will always
need ARCH_MULTIPLATFORM selected to build your platform.

This symbol doesn't automatically turn off just because you only have
one platform enabled.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
