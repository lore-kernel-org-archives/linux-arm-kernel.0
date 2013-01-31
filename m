From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 Jan 2013 19:30:38 +0800
Subject: [PATCH v3 1/4] ASoC: tlv320aic3x: Convert mic bias to a supply
 widget
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB5A48E@DBDE01.ent.ti.com>
References: <1359631394-9511-1-git-send-email-gururaja.hebbar@ti.com>
 <1359631394-9511-2-git-send-email-gururaja.hebbar@ti.com>
 <20130131112414.GE11078@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB5A48E@DBDE01.ent.ti.com>
Message-ID: <20130131113035.GF11078@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 11:27:07AM +0000, Hebbar, Gururaja wrote:
> On Thu, Jan 31, 2013 at 16:54:16, Mark Brown wrote:

> > As mentioned when you posted this before this patch needs to update the
> > machine drivers using the device too.

> The patch-set 2/4 does the same thing. Since I have da850-evm at my end, I 
> have modified that machine driver and sent-it as 2/4.

Two problems here.  One is that the update should be done in the same
patch and the other is that you need to update *all* the machine drivers
using the device, not just one of them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130131/6d513f38/attachment.sig>
