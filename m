From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Nov 2014 19:15:05 +0100
Subject: [PATCH 1/2] i2c: cadence: Remove .owner field for driver
In-Reply-To: <541FEDB5.7050305@monstr.eu>
References: <c076984af7e65c433fdfd3a3b0f8d20da2c18013.1407931005.git.michal.simek@xilinx.com>
 <20140920091106.GB1612@katana> <541FEDB5.7050305@monstr.eu>
Message-ID: <20141107181505.GK3656@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> oing this for the whole kernel will be the best. coccinelle script
> is good option I have never played with it.

Thanks, but superseded in favour of a generic solution
(https://lkml.org/lkml/2014/10/21/594).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141107/c163d349/attachment.sig>
