From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 2 Sep 2014 13:01:59 +0200
Subject: [PATCH v4] i2c: rk3x: fix bug that cause transfer fails in
 master receive mode
In-Reply-To: <1408730452-3552-1-git-send-email-addy.ke@rock-chips.com>
References: <1408669991-9703-1-git-send-email-addy.ke@rock-chips.com>
 <1408730452-3552-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20140902110159.GF1266@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 02:00:52AM +0800, Addy Ke wrote:
> In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
> in one chunk, so the size of data to be write/read to/from TXDATAx/RXDATAx
> must be less than or equal 32 bytes at a time.
> 
> Tested on rk3288-pinky board, elan receive 158 bytes data.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> Acked-by: Max Schwarz <max.schwarz@online.de>

Applied to for-current, thanks! Please don't send new versions of a
patch as reply-to of a previous version.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/b1524370/attachment.sig>
