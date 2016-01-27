From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2016 19:27:12 +0000
Subject: [PATCH] ARM: lib/lib1funcs.S: fix typo
 s/substractions/subtractions/
In-Reply-To: <1453902670-32294-1-git-send-email-ao2@ao2.it>
References: <1453902670-32294-1-git-send-email-ao2@ao2.it>
Message-ID: <20160127192711.GE10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 02:51:10PM +0100, Antonio Ospite wrote:
> While at it also fix some other typos in the affected lines:
>   s/reminder/remainder/
>   s/comparison/comparisons/
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>

Acked-by: Russell King <rmk+kernel@Arm.linux.org.uk>

Thanks.  I assume the trivial tree will be picking this up?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
