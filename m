From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 19 Dec 2010 19:00:55 +0200
Subject: [PATCH] MTD: m25p80: add debugging trace in sst_write()
In-Reply-To: <1292414372-17085-1-git-send-email-nicolas.ferre@atmel.com>
References: <1292414372-17085-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1292778055.13362.8.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-15 at 12:59 +0100, Nicolas Ferre wrote:
> Add a DEBUG(MTD_DEBUG_LEVEL2, ..) trace at beginning of sst_write() function as
> it is done in m25p80_write() function.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

So do you do this only becaus it is done in m25p80_write()? This is what
the commit message suggests... Have you found these DEBUG macros useful
for you? (I never found them any useful).

Anyway, I've put this to my l2-mtd-2.6.git tree, thanks.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
