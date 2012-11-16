From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Fri, 16 Nov 2012 10:50:49 +0200
Subject: [PATCH 1/8] mtd: diskonchip: don't warn about ARM architecture
In-Reply-To: <1352238933-4886-2-git-send-email-arnd@arndb.de>
References: <1352238933-4886-1-git-send-email-arnd@arndb.de>
 <1352238933-4886-2-git-send-email-arnd@arndb.de>
Message-ID: <1353055849.20111.7.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-11-06 at 22:55 +0100, Arnd Bergmann wrote:
> Enabling the diskonchip drivers on most architectures results
> in a pointless warning "#warning Unknown architecture for
> DiskOnChip. No default probe locations defined". The driver
> can in fact handle the default location already through the
> CONFIG_MTD_DOCPROBE_ADDRESS, which gets set on the platforms
> that need it, and we get a run-time error if this is not
> set correctly.

Pushed patches 1, 2, and 3 to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/77b59189/attachment.sig>
