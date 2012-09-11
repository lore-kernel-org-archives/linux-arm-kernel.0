From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 12 Sep 2012 00:00:48 +0200
Subject: [PATCHv7 00/23]I2C big cleanup
In-Reply-To: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120911220048.GD27031@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 03:11:55PM +0530, Shubhrajyoti D wrote:
> Changes since v1:
>        - removed tabification on patch 6/17
>        - removed dev_err() which was introduced on patch 09/17
> Changes since v2:
>         - do not set full fifo depth in the RDR interrupt.
>         - some changelog updates.
>         - rebase to the Wolfram's tree.
> Changes since v3:
>         - Remove a redundant read of status register
>         - Read the dev->buf_len variable instead of the register
>         as the information of the remaining bytes is there.
> Changes since v4:
>         - Ack the arbitration lost.
>         - Rebase to the i2c-embedded/for-next branch.
> Changes since v5:
>         - Rebase to latest mainline
>         - Added some more cleanup patches so as have a consolidated series.
> Changes since v6:
>         - Fix comments on setting the pdev to NULL.
>         - Trivial changelog update

Looks mostly good, thanks. Only a few comments. Oh, and I still get
reports about a section mismatch ;)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120912/b9d6e8b1/attachment.sig>
