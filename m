From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 14 Jul 2015 13:02:57 +0200
Subject: [PATCH 1/3] i2c: omap: switch to dev_get_drvdata()
In-Reply-To: <1436819884-1614-1-git-send-email-balbi@ti.com>
References: <20150710172701.GB20408@saruman.tx.rr.com>
 <1436819884-1614-1-git-send-email-balbi@ti.com>
Message-ID: <20150714110257.GA1517@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 03:38:02PM -0500, Felipe Balbi wrote:
> there's no need to fetch the platform_device
> in order to dereference it back to the dev
> pointer to access drvdata, we can use
> dev_get_drvdata() instead.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

All patches applied to for-next, thanks!

Please send new series as a seperate thread, don't reply to the old one!
You could have collected the tags from last version IMO, it was just a
rebase, no code change.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/6eea4404/attachment.sig>
