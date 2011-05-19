From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 19 May 2011 14:19:06 +0300
Subject: [PATCH v6 0/8] Switch ARM platforms from integrator-flash to
	physmap
In-Reply-To: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
References: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1305803946.2630.69.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-17 at 14:11 +0100, Marc Zyngier wrote:
> As the integrator-flash driver is mostly a duplicate of physmap,
> move all users of this driver to physmap and get rid of the
> then unused driver.
> 
> Also change the set_vpp() method in physmap to pass the
> platform_device instead of the map_info. This allows for a substantial
> cleanup in drivers/mtd/maps/pismo.c
> 
> This patch set has been ok'ed by RMK, who is willing to take it
> through his tree. This requires an ACK from the MTD maintainers. David
> Woodhouse cc-ed on the whole patch set in case he'd prefer to merge it
> via the MTD tree.

I assume the whole series will go in via some subsystem arm tree?

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
