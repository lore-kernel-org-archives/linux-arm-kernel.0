From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 17:14:03 +0300
Subject: [PATCH v3 3/8] wlcore: remove pwr_in_suspend from platform data
In-Reply-To: <1372860209-3504-4-git-send-email-coelho@ti.com>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-4-git-send-email-coelho@ti.com>
Message-ID: <20130703141403.GP15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 05:03:24PM +0300, Luciano Coelho wrote:
> The pwr_in_suspend flag depends on the MMC settings which can be
> retrieved from the SDIO subsystem, so it doesn't need to be part of
> the platform data structure.  Move it to the platform device data that
> is passed from SDIO to wlcore.
> 
> Signed-off-by: Luciano Coelho <coelho@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/93a6706d/attachment.sig>
