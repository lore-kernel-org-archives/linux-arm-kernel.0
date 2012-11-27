From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 27 Nov 2012 16:52:28 +0530
Subject: linux-next: manual merge of the arm-soc tree with the net-next
 tree
In-Reply-To: <20121126204546.ef1f1b55e903eda38a61d5d1@canb.auug.org.au>
References: <20121126204546.ef1f1b55e903eda38a61d5d1@canb.auug.org.au>
Message-ID: <50B4A274.5070601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2012 3:15 PM, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/boot/dts/am33xx.dtsi between commit 1a39a65cba08 ("arm/dts:
> am33xx: Add CPSW and MDIO module nodes for AM33XX") from the net-next
> tree and commits 059b185d5345 ("ARM: dts: AM33XX: Add D_CAN device tree
> data") and 4c94ac29b5c1 ("ARM: dts: OMAP: Move interrupt-parent to the
> root node to avoid duplication") (and a few others that added more later
> nodes) from the arm-soc tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
>
Stephen Rothwell

The fix is correct and I have tested CPSW from linux-next.

Regards
Mugunthan V N
