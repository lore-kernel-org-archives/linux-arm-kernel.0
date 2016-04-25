From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 26 Apr 2016 00:28:03 +0200
Subject: [PATCH v2 3/3] i2c: s3c2410: Cleanup indentation and comment style
In-Reply-To: <1461222291-5642-3-git-send-email-k.kozlowski@samsung.com>
References: <1461222291-5642-1-git-send-email-k.kozlowski@samsung.com>
 <1461222291-5642-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160425222802.GN1550@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 09:04:51AM +0200, Krzysztof Kozlowski wrote:
> Improve the readability by:
>  - fixing indentation,
>  - switching to proper block comments,
>  - removing spurious blank lines,
>  - checkpatch: void function return statements are not generally useful,
>  - checkpatch: braces {} are not necessary for any arm of this
>    statement,
>  - checkpatch: missing a blank line after declarations.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160426/c4794d39/attachment.sig>
