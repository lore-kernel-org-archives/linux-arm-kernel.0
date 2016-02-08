From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Feb 2016 17:10:10 +0000
Subject: [PATCH 1/2] ARM: make virt_to_idmap() return unsigned long
In-Reply-To: <56B33BAC.6020303@ti.com>
References: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
 <56A84748.3040108@oracle.com>
 <20160201152015.GU10826@n2100.arm.linux.org.uk>
 <56AF8F54.7030805@ti.com> <56AF917F.9030505@oracle.com>
 <56B14546.4070808@oracle.com> <56B20B2E.7060408@ti.com>
 <56B2201B.7020205@ti.com>
 <20160203195905.GC10826@n2100.arm.linux.org.uk>
 <56B33BAC.6020303@ti.com>
Message-ID: <20160208171009.GP10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 01:53:16PM +0200, Grygorii Strashko wrote:
> This patch boot/reboot tested on k2hk-evm (LPAE=y), ping works (with netcp regression fixed)
> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>

Thanks.  I've pushed /both/ patches out into linux-next, even though
no one's tested the second patch.

I'll wait for some progress on the TI side though; I'm unable to do
anything further on kexec until there's some movement on the items
I've requested (either kexec userspace tool patches, so I can test
locally, or a tested kexec kernel patch updated for these two changes.)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
