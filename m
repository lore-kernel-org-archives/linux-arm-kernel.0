From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 May 2016 11:41:54 +0100
Subject: [PATCH v3 5/7] ASoc: omap-mcbsp: Rename
 omap_mcbsp_sysfs_remove() to omap_mcbsp_cleanup()
In-Reply-To: <1461927202-17677-6-git-send-email-peter.ujfalusi@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
 <1461927202-17677-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160502104154.GC6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 01:53:20PM +0300, Peter Ujfalusi wrote:
> The function will do more then removing the sysfs files in the future.

Please fix the subject line but otherwise this looks OK.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/95287bcb/attachment.sig>
