From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Jul 2014 18:10:35 +0100
Subject: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource
 subsystem
In-Reply-To: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
References: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140718171035.GQ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 01:30:53PM +0200, Lothar Wa?mann wrote:
> Aua. This really hurts. I wonder how this could ever be admitted to
> the Linux kernel...
> Further comments suppressed because the would most likely violate the
> CDA.
> 
> If someone should not grasp what this patch does, they should consider
> what happens upon unloading/reloading the kernel module.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

I'm not going to apply this with a commit message such as the above.
Quite aside from the tone the fact that it doesn't describe the issue
is not helpful for review, one of the things done in review is to try to
check that the change has the intended effect.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/662acef2/attachment.sig>
