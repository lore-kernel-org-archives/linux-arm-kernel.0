From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 12:45:08 +0300
Subject: [PATCH v7 6/9] ARM: dts: omap: update usb_otg_hs data
In-Reply-To: <1371113039-5784-7-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-7-git-send-email-kishon@ti.com>
Message-ID: <20130618094508.GU5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 02:13:56PM +0530, Kishon Vijay Abraham I wrote:
> Updated the usb_otg_hs dt data to include the *phy* and *phy-names*
> binding in order for the driver to use the new generic PHY framework.
> Also updated the Documentation to include the binding information.
> The PHY binding information can be found at
> Documentation/devicetree/bindings/phy/phy-bindings.txt
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/756503b6/attachment.sig>
