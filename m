From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Apr 2013 17:47:51 +0100
Subject: [PATCH 18/30] ASoC: samsung: move plat/ headers to local directory
In-Reply-To: <1365638712-1028578-19-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-19-git-send-email-arnd@arndb.de>
Message-ID: <20130411164751.GK9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:05:00AM +0200, Arnd Bergmann wrote:
> The plat/iis.h and plat/ac97.h files in the samsung platform are
> only needed by the ASoC drivers, so they can be moved into the
> same directory, as one more step towards a multiplatform build.

This doesn't apply to my topic/samsung branch, can you please regenerate
it against that or let me know what to apply it against?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130411/712ec25b/attachment.sig>
