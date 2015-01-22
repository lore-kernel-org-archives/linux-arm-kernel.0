From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Jan 2015 15:14:27 +0100
Subject: [PATCH 1/1] i2c: i2c-st: Rename clock reference to something
 that exists
In-Reply-To: <20150122121819.GC9129@x1>
References: <1409234523-20240-1-git-send-email-lee.jones@linaro.org>
 <20150122121819.GC9129@x1>
Message-ID: <20150122141427.GA3413@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 12:18:19PM +0000, Lee Jones wrote:
> Wolfram,
> 
> This patch has been on the list since forever.

For reasons :)

a) It was not CCed to the i2c list, so it doesn't show up in patchwork
which does the patch tracking for me.

b) I was always under the impression that Maxime is going to take it?
He said so.

> I have Acks from the driver author, so I'm going to take this through
> the MFD tree.  If you perk up later and decide to take it though the
> I2C tree instead, let me know and I'll remove it from MFD.

Well, I2C makes more sense than MFD, so I'll pick it up right now.
ST-tree would have also been fine.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150122/06a2b530/attachment.sig>
