From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 27 Jan 2012 16:16:14 +0200
Subject: [PATCH 1/2] MTD: sa11x0: Remove shutdown handler
In-Reply-To: <E1RoBvE-0005qY-BC@rmk-PC.arm.linux.org.uk>
References: <E1RoBvE-0005qY-BC@rmk-PC.arm.linux.org.uk>
Message-ID: <1327673774.29385.2.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-01-20 at 10:42 +0000, Russell King - ARM Linux wrote:
> Commit c4a9f88daf ([MTD] [NOR] fix ctrl-alt-del can't reboot for
> intel flash bug) interferes with this work-around, causing MTD to
> issue this warning:
> 
> 	Flash device refused suspend due to active operation (state 0)
> 
> The commit makes our work-around in the map driver unnecessary, so
> let's remove it.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Pushed both to l2-mtd tree, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120127/fce11d65/attachment-0001.sig>
