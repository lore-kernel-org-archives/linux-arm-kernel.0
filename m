From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Feb 2018 11:19:44 +0100
Subject: [PATCH V2] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <CAMuHMdVO7sxRjj7h=ar+bA8B3Art=Yyyr66cRqC30pw3Zz+Vag@mail.gmail.com>
References: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVO7sxRjj7h=ar+bA8B3Art=Yyyr66cRqC30pw3Zz+Vag@mail.gmail.com>
Message-ID: <20180215101944.qtiquqqhgmg3gbrt@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> As the code now always sends 3 i2c msgs to all 3 possible regulators, we
> may accidentally talk to another device at 0x70 on other boards than Stout.

It sends per device, so unless there is a device named "da9210" at
addr 0x70, nothing will happen? Am I missing something?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180215/37c9cc28/attachment-0001.sig>
