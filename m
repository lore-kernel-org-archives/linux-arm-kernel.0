From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 16 Aug 2012 16:15:38 +0200
Subject: [PATCHv7 00/24] I2C big cleanup
In-Reply-To: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
References: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120816141538.GA13740@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 07:33:31PM +0530, Shubhrajyoti D wrote:
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
> 
> Tested on omap4sdp and 3430sdp.
> 
> The following changes since commit 3bf671af14d591ede9251acb0085e8017f3705e7:
> 
>   Merge branch 'fixes-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/git/cooloney/linux-leds (2012-08-13 09:59:04 +0300)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linus-tree/linus-tree.git for_3.6/i2c/big_cleanup

A GIT tree, thanks for that!

Since the series is quite huge, I'd appreciate it if you could wait for
reviews a little bit (a few days) and collect the issues raised there
before resending. I know "release early & often", yet the traffic causes
some overhead here :)

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120816/a48a0b08/attachment.sig>
