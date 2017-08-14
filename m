From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 14 Aug 2017 18:29:41 +0200
Subject: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
In-Reply-To: <20170814162108.GW8569@atomide.com>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-3-wsa@the-dreams.de>
 <20170523071819.4zpdef7ofzz3moil@dell>
 <20170813133445.vqbfelwshvrififp@ninjato>
 <20170814064355.foiilzr5cmwk65hr@dell>
 <20170814084412.dfbsqfwrgmy5bsu3@dell>
 <20170814162108.GW8569@atomide.com>
Message-ID: <20170814162941.qns2k2u4t643kivy@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Even if it doesn't, it still requires Acks.
> 
> As long as this has been compile tested with omap1_defconfig:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Hah, just in time. I was about to send out the new version, thanks! :D

buildbot did test it and I did compile tests, too.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170814/9fdf04d7/attachment.sig>
