From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Mar 2016 23:16:55 +0100
Subject: [PATCH v1 1/2] dt-bindings: modify document of Rockchip power
 domains
In-Reply-To: <7hshznsqs4.fsf@baylibre.com>
References: <1458285444-31129-1-git-send-email-zhangqing@rock-chips.com>
 <1458285444-31129-2-git-send-email-zhangqing@rock-chips.com>
 <7hshznsqs4.fsf@baylibre.com>
Message-ID: <21140203.EjVS0MZtuq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 18. M?rz 2016, 09:18:51 schrieb Kevin Hilman:
> Elaine Zhang <zhangqing@rock-chips.com> writes:
> > Add qos example for power domain which found on Rockchip SoCs.
> > These qos register description in TRMs
> > (rk3036, rk3228, rk3288, rk3366, rk3368, rk3399) looks the same.
> 
> This should describe in more detail what "qos" is in this context.  At
> first glance, it's just a range of registers that lose context that need
> to be saved/restored.

I guess that should be something like

---- 8< ----
Rockchip SoCs contain quality of service (qos) blocks managing priority, 
bandwidth, etc of the connection of each domain to the interconnect.
These blocks loose state when their domain gets disabled and therefore
need to be saved when disabling and restored when enabling a power-domain.

These qos blocks also are similar over all currently available Rockchip 
SoCs.
---- 8< ----
