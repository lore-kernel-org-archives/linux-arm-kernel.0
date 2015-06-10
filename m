From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 10 Jun 2015 22:09:48 +0900
Subject: [PATCH v6 0/6] i2c: at91: add support to FIFOs and alternative
 command
In-Reply-To: <20150610125708.GE1592@katana>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
 <20150610125708.GE1592@katana>
Message-ID: <20150610130947.GG1592@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> After fixing the version string in patch 5 as mentioned there, and added
> the acks from Ludovic for the previous version.
> 
> Applied to for-next, thanks!

And unrelated to your series, just in case you feel like it, my code checkers
say:

drivers/i2c/busses/i2c-at91.c:213: style: Checking if unsigned variable 'buf_len' is less than zero.
drivers/i2c/busses/i2c-at91.c:254: style: Checking if unsigned variable 'buf_len' is less than zero.
drivers/i2c/busses/i2c-at91.c:293: style: Checking if unsigned variable 'buf_len' is less than zero.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150610/ffc56999/attachment.sig>
