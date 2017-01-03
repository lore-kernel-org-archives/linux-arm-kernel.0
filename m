From: eric@anholt.net (Eric Anholt)
Date: Tue, 03 Jan 2017 10:04:28 -0800
Subject: [PATCH 2/2] mmc: sdhci-iproc: Increase max_blk_size for bcm2835
In-Reply-To: <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
 <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87o9zonhoz.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> According to the BCM2835 datasheet the maximum block size for the
> eMMC module is restricted to the internal data FIFO which is 1024 byte.
> But this is still an improvement to the default of 512 byte.

Confirmed that the internal FIFOs are 1k.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170103/e734aeda/attachment.sig>
