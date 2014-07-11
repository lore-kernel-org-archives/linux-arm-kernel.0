From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Jul 2014 14:54:00 +0100
Subject: [PATCH 0/4] ASoC: samsung updates from arm testing
In-Reply-To: <1405086308-1461192-2-git-send-email-arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-2-git-send-email-arnd@arndb.de>
Message-ID: <20140711135400.GY30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 03:45:03PM +0200, Arnd Bergmann wrote:

> Here are a few patches from my randconfig and multiplatform series.
> The smartq patch is a re-send of the one I screwed up the other day.
> the dependencies and dma data removal should be trivial, the
> dmaengine one probably needs some closer inspection.

Hrm, can you check what's going on with the series - I've got two copies
of patch 2 and an extra patch [PATCH] ASoC: s3c64xx/smartq: use dynamic
registration which is threaded before this cover letter and looks like a
resend of the prior copy with the platform_data header missing that got
included by mistake?  The patches look OK but I just want to make sure
I'm applying the right things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/beecccc7/attachment-0001.sig>
