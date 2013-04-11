From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Apr 2013 17:48:44 +0100
Subject: [PATCH 21/30] ASoC: samsung/i2s: fix module_device_table
In-Reply-To: <1365638712-1028578-22-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-22-git-send-email-arnd@arndb.de>
Message-ID: <20130411164844.GM9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:05:03AM +0200, Arnd Bergmann wrote:
> The second argument to the module_device_table macro must be the
> name of the device id array. In the samsung i2s driver, there
> was a small typo, resulting in a build error when building it
> as a loadable module.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130411/4ef8151e/attachment.sig>
