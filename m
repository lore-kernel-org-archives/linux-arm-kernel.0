From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 16 Oct 2011 14:38:14 +0300
Subject: [PATCH 14/26] mtd: nand_h1900 never worked
In-Reply-To: <1317499438-14058-15-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-15-git-send-email-arnd@arndb.de>
Message-ID: <1318765103.2935.3.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-10-01 at 22:03 +0200, Arnd Bergmann wrote:
> This driver has been broken through all of git history and
> cannot even be built. Better mark it as broken. Next stop is
> removing from the tree.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Pushed to l2-mtd-2.6.git, thanks!

NB: I'd just killed it instead...

-- 
Best Regards,
Artem Bityutskiy
