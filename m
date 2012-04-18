From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Apr 2012 17:56:50 +0100
Subject: [PATCH v2 0/8] Second patchset for LPC32xx device tree conversion
In-Reply-To: <201204181100.40123.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <201204180806.16848.arnd@arndb.de> <20120418093604.GL6498@mwanda>
 <201204181100.40123.arnd@arndb.de>
Message-ID: <20120418165650.GD3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 11:00:39AM +0000, Arnd Bergmann wrote:

> 1. develop on -rc
> 2. merge with latest -next, test and make sure it works there
> 3. submit for review against -rc
> 4. have patches included in -next once reviewed, but based on -rc
> 5. when merge window opens, have patches sent for upstream inclusion

Steps 3 and 4 should be to submit against whatever branch is appropriate
for the subsystem and driver - if people follow this process they're
going to get bounced back by a fair proportion of maintainers, -rc isn't
universally what people are looking for so people should be aware that
they need to pay attention here.  

Generally I'd say the development version is a safer bet than -rc for
most subsystems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/5cba43a5/attachment.sig>
