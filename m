From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 18:20:23 +0300
Subject: [PATCH v8 6/8] usb: musb: omap2430: use the new generic PHY
 framework
In-Reply-To: <1372139926-3719-7-git-send-email-kishon@ti.com>
References: <1372139926-3719-1-git-send-email-kishon@ti.com>
 <1372139926-3719-7-git-send-email-kishon@ti.com>
Message-ID: <20130625152022.GK21334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:28:44AM +0530, Kishon Vijay Abraham I wrote:
> Use the generic PHY framework API to get the PHY. The usb_phy_set_resume
> and usb_phy_set_suspend is replaced with power_on and
> power_off to align with the new PHY framework.
> 
> musb->xceiv can't be removed as of now because musb core uses xceiv.state and
> xceiv.otg. Once there is a separate state machine to handle otg, these can be
> moved out of xceiv and then we can start using the generic PHY framework.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/4193429f/attachment.sig>
