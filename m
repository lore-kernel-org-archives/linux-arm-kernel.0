From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 12:18:18 -0600
Subject: [PATCH v5 1/9] phy: add phy_get_bus_width()/phy_set_bus_width()
 calls
In-Reply-To: <1386854770-2173-2-git-send-email-mporter@linaro.org>
References: <1386854770-2173-1-git-send-email-mporter@linaro.org>
 <1386854770-2173-2-git-send-email-mporter@linaro.org>
Message-ID: <20131212181818.GI1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 12, 2013 at 08:26:02AM -0500, Matt Porter wrote:
> This adds a pair of APIs that allows the generic PHY subsystem to
> provide information on the PHY bus width. The PHY provider driver may
> use phy_set_bus_width() to set the bus width that the PHY supports.
> The controller driver may then use phy_get_bus_width() to fetch the
> PHY bus width in order to properly configure the controller.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>

Kishon, I need your Acked-by here, if you're ok with the change.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/93a301fd/attachment.sig>
