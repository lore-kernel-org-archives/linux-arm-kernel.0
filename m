From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Aug 2017 09:37:16 +0100
Subject: [PATCH v2 0/8] ELF-FDPIC support for ARM
In-Reply-To: <20170817072347.19990-1-nicolas.pitre@linaro.org>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
Message-ID: <20170817083716.GN20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 03:23:39AM -0400, Nicolas Pitre wrote:
> This series provides the needed changes to suport the ELF_FDPIC binary
> format on ARM. Both MMU and non-MMU systems are supported. This format
> has many advantages over the BFLT format used on MMU-less systems, such
> as being real ELF that can be parsed by standard tools, can support
> shared dynamic libs, etc.

I don't see anything issues from the core arch point of view with this,
most of it looks straight forward, and the impact on existing users
should be low.  However, it would be nice to get some acks (if possible)
for the non-arch stuff and some tested-by's on this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
