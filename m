From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 26 Apr 2016 00:23:12 +0200
Subject: [PATCH v2 1/3] i2c: s3c2410: Add missing clock unprepare on
 probe() error path
In-Reply-To: <1461222291-5642-1-git-send-email-k.kozlowski@samsung.com>
References: <1461222291-5642-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160425222312.GL1550@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 09:04:49AM +0200, Krzysztof Kozlowski wrote:
> If during probe() the s3c24xx_i2c_init() failed, the clock was left in
> disabled but prepared state.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160426/257c674b/attachment.sig>
