From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Mar 2014 23:51:39 +0100
Subject: [PATCH v5 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <20140314180038.GT18529@joshc.qualcomm.com>
References: <1394762863-12154-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20140314180038.GT18529@joshc.qualcomm.com>
Message-ID: <20140328225139.GC29200@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> General i2c question: is there a reason why the core isn't responsible
> for ensuring a device is not suspended before invoking ->master_xfer
> (and smbus_xfer)?

Can't think of one right now.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/f7d15305/attachment.sig>
