From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 Jan 2013 14:27:40 +0000
Subject: [alsa-devel] [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB3690C@DBDE01.ent.ti.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB3690C@DBDE01.ent.ti.com>
Message-ID: <20130107142740.GG4544@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 09:20:16AM +0000, Hebbar, Gururaja wrote:

> I will be looking into this now. To speed up the things, do you have any
> reference link/implementation which  I can refer to?

Any modern CODEC driver.

> I looked at the OMAP implementation but they are following the same (meaning both
> DT & non-DT use similar audio map for routing).

You should use the same setup for DT and non-DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130107/9ffbd211/attachment.sig>
