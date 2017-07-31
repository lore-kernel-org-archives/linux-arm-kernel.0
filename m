From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 31 Jul 2017 17:30:09 +0200
Subject: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
In-Reply-To: <20170615185418.13980-1-javier@dowhile0.org>
References: <20170615185418.13980-1-javier@dowhile0.org>
Message-ID: <20170731153009.xkjknygpmckv2pfp@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Patches can be applied independently since the DTS changes without driver
> changes are no-op and the OF table won't be used without the DTS changes.

But there is a dependency, no? If I apply the driver patch,
non-converted device trees will not find their eeproms anymore. So, I
need to wait until all DTS patches are upstream, right? I can pick patch
1, though. We can already document it.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/696b547b/attachment-0001.sig>
