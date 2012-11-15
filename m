From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 15 Nov 2012 16:50:11 +0100
Subject: [PATCH 1/1] mtd: physmap_of: allow to specify the mtd name for
 retro compatiblity
In-Reply-To: <20121115131926.47F853E0B12@localhost>
References: <1352062641-31850-1-git-send-email-plagnioj@jcrosoft.com>
 <20121115131926.47F853E0B12@localhost>
Message-ID: <20121115155011.GD4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:19 Thu 15 Nov     , Grant Likely wrote:
> On Sun,  4 Nov 2012 21:57:21 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > linux,mtd-name allow to specify the mtd name for retro capability with
> > physmap-flash drivers as boot loader pass the mtd partition via the old
> > device name physmap-flash.
> 
> Ummm. I don't follow. Could you explain more about how this change will
> be used?
the bootloader pass the nor flash (aka physmap) partitions via cmdline

when switching to DT the mtd name change so the kernel does not found the
partition table anymore as the mtd name is now the node name

and no I can not change the bootloader (product on the market)

Best Regards,
J.
