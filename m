From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Dec 2015 16:17:41 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <2592093.cGKEcKVqLU@wuerfel>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2592093.cGKEcKVqLU@wuerfel>
Message-ID: <20151210151741.GE1573@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Alternatively, the  inline could return an error, and both bus
> drivers check for the error before using 'value'.

I'll try to check these options tomorrow.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151210/7fcd5b3c/attachment.sig>
