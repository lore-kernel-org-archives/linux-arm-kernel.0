From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 9 Jul 2015 21:46:17 +0200
Subject: [PATCH 1/3] i2c: omap: switch to dev_get_drvdata()
In-Reply-To: <1435260890-32335-1-git-send-email-balbi@ti.com>
References: <1435260890-32335-1-git-send-email-balbi@ti.com>
Message-ID: <20150709194616.GG4744@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 02:34:48PM -0500, Felipe Balbi wrote:
> there's no need to fetch the platform_device
> in order to dereference it back to the dev
> pointer to access drvdata, we can use
> dev_get_drvdata() instead.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/92c65ddd/attachment.sig>
