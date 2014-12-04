From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Dec 2014 19:32:43 +0100
Subject: [PATCH v2 1/3] i2c: cadence: Handle > 252 byte transfers
In-Reply-To: <1417610126-7957-2-git-send-email-harinik@xilinx.com>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-2-git-send-email-harinik@xilinx.com>
Message-ID: <20141204183242.GJ7944@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +		/*
> +		 * If the device is sending data If there is further
> +		 * data to be sent. Calculate the available space
> +		 * in FIFO and fill the FIFO with that many bytes.
> +		 */

This comment looks broken. In general, I think there should be more
comments explaining why things have to be done this way.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/f1e23a22/attachment.sig>
