From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 12 Mar 2015 15:56:07 +0100
Subject: [RFC V2 12/12] i2c: bcm-iproc: make use of the new
 infrastructure for quirks
In-Reply-To: <54EFAD2A.9060501@broadcom.com>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
 <54EFAD2A.9060501@broadcom.com>
Message-ID: <20150312145607.GC9572@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Change on the iproc i2c driver looks good to me. Sanity tested the
> change from Wolfram's i2c/quirks branch on Cygnus 958300K combo board.
> Sanity tested with an attempt to transfer large amount of I2C data to
> ensure the transfer is denied by the i2c-core:
> 
> / # cat /dev/i2c-0
> [  657.310261] i2c i2c-0: quirk: msg too long (addr 0x0000, size 4096, read)
> 
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Tested-by: Ray Jui <rjui@broadcom.com>

Thanks for testing, and especially describing your test! Much
appreciated.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150312/3063923f/attachment.sig>
