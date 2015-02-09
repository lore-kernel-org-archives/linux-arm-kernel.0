From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 9 Feb 2015 11:03:33 +0100
Subject: [PATCH v8 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <54D7A694.4000903@broadcom.com>
References: <rjui@broadcom.com>
 <1423272507-18459-1-git-send-email-rjui@broadcom.com>
 <1423272507-18459-3-git-send-email-rjui@broadcom.com>
 <20150207175039.GB6263@katana> <54D6EF3D.4030302@broadcom.com>
 <20150208110325.GA2750@katana> <54D7A694.4000903@broadcom.com>
Message-ID: <20150209100332.GA1002@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Okay. Let me check with our ASIC engineer to see if there's a way to get
> the driver extended to support the case when data size is larger than
> the FIFO size. From my understanding based on the data sheet I have, I
> don't think that can be done with this controller. But if the ASIC
> engineers tells me the opposite, I'll add it as a separate patch later.

Perfect, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150209/b20c9302/attachment.sig>
