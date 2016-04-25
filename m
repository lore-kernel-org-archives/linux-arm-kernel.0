From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 26 Apr 2016 00:20:51 +0200
Subject: [PATCH v2 2/2] i2c: s3c2410: Check clk_prepare_enable() return
 value
In-Reply-To: <1461163076-5959-2-git-send-email-javier@osg.samsung.com>
References: <1461163076-5959-1-git-send-email-javier@osg.samsung.com>
 <1461163076-5959-2-git-send-email-javier@osg.samsung.com>
Message-ID: <20160425222051.GK1550@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 10:37:56AM -0400, Javier Martinez Canillas wrote:
> The clk_prepare_enable() function can fail so check the return
> value and propagate the error in case of a failure.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160426/07519846/attachment.sig>
