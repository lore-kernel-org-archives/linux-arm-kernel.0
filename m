From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 12 Sep 2012 15:16:15 +0200
Subject: [PATCHv8 00/23]I2C big cleanup
In-Reply-To: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120912131615.GB16547@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 04:27:54PM +0530, Shubhrajyoti D wrote:
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
> Changes since v7:
> 	- Remove a patch as the code is getting changed anyways
> 	- Changelogs update.
> 
> Previous discussions can be found here 
> http://www.spinics.net/lists/linux-i2c/msg09764.html
> 
> This is the cleanup only series.
>   
> Tested on omap4sdp and 3430sdp.
> 
> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
> 
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/linus-tree/linus-tree.git for_3.7/i2c/big_cleanups

Pushed to -next. Thanks to all involved!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120912/629622f5/attachment.sig>
