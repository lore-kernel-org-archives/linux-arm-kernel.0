From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 20 Oct 2015 18:18:04 +0200
Subject: [RESEND PATCH 0/4] i2c: Fix module autoload for OF platform
 drivers
In-Reply-To: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
References: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Message-ID: <20151020161802.GP5379@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 03:16:26PM +0100, Luis de Bethencourt wrote:
> Hello,
> 
> This is a resend of this patch series. It was posted on September 17. [0]
> 
> These patches add the missing MODULE_DEVICE_TABLE() for OF to export
> the information so modules have the correct aliases built-in and
> autoloading works correctly.
> 
> A longer explanation by Javier Canillas can be found here:
> https://lkml.org/lkml/2015/7/30/519
> 
> The 4th patch of the series is Acked-by Linus Walleij.

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151020/88299910/attachment.sig>
