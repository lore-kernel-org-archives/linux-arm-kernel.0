From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Nov 2012 06:43:13 +0000
Subject: [PATCH] ARM: SAMSUNG: Fix build of I2S driver
In-Reply-To: <15c501cdcc36$db54cb00$91fe6100$%kim@samsung.com>
References: <1353944420-3972-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <15c501cdcc36$db54cb00$91fe6100$%kim@samsung.com>
Message-ID: <20121127064313.GV9411@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 09:33:43AM +0900, Kukjin Kim wrote:

> I checked Samsung audio driver stuff just now. If you don't mind, I will
> drop the patch 48a2050d ("ARM: SAMSUNG: Delete the unnecessary variable")
> instead of applying this.

That works just as well for me, thanks.  Padma, as I said in the commit
log this should be done as part of a single patch series rather than
sending separately to ARM or ASoC so that both trees continue to build
at each point.

> If any unprepared patches for Samsung audio in my tree, please let me know.

Will do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/5cc18e82/attachment.sig>
