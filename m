From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 5 Nov 2017 23:08:45 +0100
Subject: [PATCH 0/2] ARM: pxa: move pxa-i2c.h to platform_data
In-Reply-To: <20171105141226.13624-1-wsa@the-dreams.de>
References: <20171105141226.13624-1-wsa@the-dreams.de>
Message-ID: <20171105220845.edwugarkt2te7ak4@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> As discussed previously, we move the declarations now to devices.h and the
> platform_data to the platform_data directory. Only build tested, but buildbot
> is happy.

Well, after the initial success message, it looks Buildbot is not happy,
after all. It found 3 more boards which needed to include "devices.h". I
did some own scanning and pushed out an improved patchset. I will wait
a bit longer for reports this time, too.

But this series should still give you an idea about the approach.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171105/49bde2d9/attachment.sig>
