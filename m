From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 30 Apr 2013 10:28:35 +0300
Subject: [PATCH V2] video: implement a simple framebuffer driver
In-Reply-To: <2863648.BDvrAG5uPk@flatron>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <20130408171637.98b5ad1f867bcbda883af68b@linux-foundation.org>
 <2569832.XQDrhUGNaI@avalon> <2863648.BDvrAG5uPk@flatron>
Message-ID: <517F72A3.6010009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2013 12:15 AM, Tomasz Figa wrote:

> Well, there is also at least one legitimate use case for this driver.
> 
> I believe there exist embedded devices on which there is no need to 
> dynamically control the framebuffer. It needs one time initialization, 
> usually in bootloader, and then it is used as is, using constant 
> parameters as long as the system is running.
> 
> I doubt there is a need for any KMS (or any other control) driver for such 
> devices - dumb framebuffer driver would be everything needed in such case.

Isn't there usually the need to power off the hardware when
blanking/suspending?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130430/651fadab/attachment.sig>
