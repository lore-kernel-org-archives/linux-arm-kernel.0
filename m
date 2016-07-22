From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 22 Jul 2016 09:28:01 +0200
Subject: [PATCH] i2c: bcm2835: Don't complain on -EPROBE_DEFER from
 getting our clock
In-Reply-To: <1455844375-15019-1-git-send-email-eric@anholt.net>
References: <1455844375-15019-1-git-send-email-eric@anholt.net>
Message-ID: <20160722072801.GH1605@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 05:12:55PM -0800, Eric Anholt wrote:
> Fixes dmesg spam when we just need to wait a moment for the clock
> driver to probe.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/ce71074e/attachment.sig>
