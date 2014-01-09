From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Jan 2014 11:00:57 +0100
Subject: [RFC PATCH 6/9] mtd: nand: add sunxi NFC dt bindings doc
In-Reply-To: <52CE5E5A.6050209@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
 <201401082228.55807.arnd@arndb.de> <52CE5E5A.6050209@overkiz.com>
Message-ID: <201401091100.58174.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014, boris brezillon wrote:
> Sure, I'll remove references to the NFC acronym:
>   - change compatible string to "allwinner,sun4i-nand"
>   - avoid NFC references in the doc
>   - rename the driver into sunxi-nand.c (formerly sunxi_nfc.c)
> 
> Do you see any other references to this acronym ?
> 

Those are the important ones, thanks!

Regarding the binding, I would mention nfc once there to help people
that happen to look for that.

	Arnd
