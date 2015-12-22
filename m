From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 11:32:22 -0800
Subject: [PATCH V2 3/3] ARM: multi_v7_defconfig: Enable generic SoC
 internal OMAP regulators
In-Reply-To: <1450118580-24754-4-git-send-email-nm@ti.com>
References: <1450118580-24754-1-git-send-email-nm@ti.com>
 <1450118580-24754-4-git-send-email-nm@ti.com>
Message-ID: <20151222193222.GY30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 12:43:00PM -0600, Nishanth Menon wrote:
> ABB and PBIAS are internal LDO control regulators that are needed for
> maintaining proper functionality of OMAP architecture SoCs. Enable the
> same. PBIAS is already enabled, so just enable ABB regulator as well.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied, thanks.


-Olof
