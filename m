From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Apr 2015 18:09:49 +0100
Subject: [PATCH v3] ASoC: max98090: add shutdown callback for max98090
In-Reply-To: <1428491156-31803-1-git-send-email-wxt@rock-chips.com>
References: <1428491156-31803-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20150408170949.GD6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 07:05:56PM +0800, Caesar Wang wrote:
> To fix pop noise when shutdown,the pop noise during shutdown
> is the pmic cutoff power of codec without any notice.

Applied, thanks.  

Please do make an effort to only send patches to relevant people -
sending people patches that aren't relevant to them adds to the volume
of mail they have to handle which can get in the way of things that need
the attention.  For example I'm not sure why the dri-devel list is on
this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150408/205c6ef6/attachment.sig>
