From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 6 Feb 2018 14:57:51 +0100
Subject: [PATCH 0/4] tree-wide: fix comparison to bitshift when dealing
 with a mask
In-Reply-To: <alpine.DEB.2.20.1802061453440.3306@hadrien>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
 <20180206131044.oso33fvv553trrd7@mwanda>
 <alpine.DEB.2.20.1802061414340.3306@hadrien>
 <20180206132335.luut6em3kut7f7ej@mwanda>
 <alpine.DEB.2.20.1802061439110.3306@hadrien>
 <20180206135310.deiaz55xemc26xn4@ninjato>
 <alpine.DEB.2.20.1802061453440.3306@hadrien>
Message-ID: <20180206135751.o7z7sxs3xtm5kbag@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I did that too but got no results.  Perhaps right shifting constants is
> pretty uncommon.  I can put that in the complete rule though.

Please do. Even if rare, we would want this bug pointed out, right? :)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180206/154ec951/attachment.sig>
