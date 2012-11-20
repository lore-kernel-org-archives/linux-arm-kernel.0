From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Nov 2012 15:42:59 +0900
Subject: [PATCH 152/493] watchdog: remove use of __devinit
In-Reply-To: <1353349642-3677-152-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-152-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120064257.GK10560@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:21:41PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/9db7948e/attachment.sig>
