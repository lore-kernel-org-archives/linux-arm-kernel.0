From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Mar 2014 23:04:43 -0500
Subject: [PATCH v2 5/5] phy: mvebu-sata: prepare new Dove DT Kconfig
 variable
In-Reply-To: <1393662801-17950-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393662801-17950-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140304040443.GI1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 09:33:21AM +0100, Sebastian Hesselbarth wrote:
> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> DT-only MACH_DOVE Kconfig.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Kishon,
> 
> Mark Brown requested to take the corresponding ASoC patch through
> his tree. Therefore, I have split the former patch into individual subsystem
> patches. This patch also received an update, to not break bisectability
> we add DT-enabled MACH_DOVE and maintain ARCH_DOVE, which is non-DT only
> after conversion. ARCH_DOVE will be removed, when legacy mach-dove will
> be removed.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/phy/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Kishon,

fwiw:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
