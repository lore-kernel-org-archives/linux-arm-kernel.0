From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 19 Mar 2016 09:04:08 +0100
Subject: [PATCH v4 1/8] arm64: dts: rockchip: Clean up /memory nodes
In-Reply-To: <1458136727-32075-2-git-send-email-afaerber@suse.de>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
 <1458136727-32075-2-git-send-email-afaerber@suse.de>
Message-ID: <2027561.JLzKLXOoFO@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 16. M?rz 2016, 14:58:39 schrieb Andreas F?rber:
> A dtc update results in warnings for nodes with reg property but without
> unit address in the node name, so rename /memory to /memory at 0.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

applied to a dts64-fixes branch for 4.6, after changing the commit message to
----
A dtc update results in warnings for nodes with reg property but without
unit address in the node name, so rename /memory to /memory at startaddress
(memory starts at 0 in the case of the rk3368).
----

To clarify that the @0 is not arbitary chosen.


Heiko
