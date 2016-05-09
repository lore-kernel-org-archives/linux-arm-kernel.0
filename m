From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 9 May 2016 23:21:19 +0200
Subject: [PATCH 0/3] HSI: omap-ssi: regressions against yesterday's
 linux-next
In-Reply-To: <1462288586-584690-1-git-send-email-arnd@arndb.de>
References: <1462288586-584690-1-git-send-email-arnd@arndb.de>
Message-ID: <20160509212118.GD1129@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, May 03, 2016 at 05:16:19PM +0200, Arnd Bergmann wrote:
> One patch you added yesterday unfortunately caused (at least) three
> separate build problems with 32-bit ARM randconfig builds.
> 
> These three patches should make it all work again.

Sorry for the delayed respones, I was on vacation last week and
asked Stephen to temp. disable the HSI tree. I just applied all
patches and asked him to reenable it.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160509/b6561e5d/attachment.sig>
