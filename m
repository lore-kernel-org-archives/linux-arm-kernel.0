From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 18:17:53 +0300
Subject: [PATCH v8 1/8] drivers: phy: add generic PHY framework
In-Reply-To: <1372139926-3719-2-git-send-email-kishon@ti.com>
References: <1372139926-3719-1-git-send-email-kishon@ti.com>
 <1372139926-3719-2-git-send-email-kishon@ti.com>
Message-ID: <20130625151753.GF21334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 25, 2013 at 11:28:39AM +0530, Kishon Vijay Abraham I wrote:
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> new file mode 100644
> index 0000000..7abf573
> --- /dev/null
> +++ b/include/linux/phy/phy.h

on this header, how about adding phy_set_drvdata() and phy_get_drvdata()
helpers ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/be6c70be/attachment.sig>
