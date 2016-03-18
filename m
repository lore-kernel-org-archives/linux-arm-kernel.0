From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 18 Mar 2016 09:18:51 -0700
Subject: [PATCH v1 1/2] dt-bindings: modify document of Rockchip power
 domains
In-Reply-To: <1458285444-31129-2-git-send-email-zhangqing@rock-chips.com>
 (Elaine Zhang's message of "Fri, 18 Mar 2016 15:17:23 +0800")
References: <1458285444-31129-1-git-send-email-zhangqing@rock-chips.com>
 <1458285444-31129-2-git-send-email-zhangqing@rock-chips.com>
Message-ID: <7hshznsqs4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elaine Zhang <zhangqing@rock-chips.com> writes:

> Add qos example for power domain which found on Rockchip SoCs.
> These qos register description in TRMs
> (rk3036, rk3228, rk3288, rk3366, rk3368, rk3399) looks the same.

This should describe in more detail what "qos" is in this context.  At
first glance, it's just a range of registers that lose context that need
to be saved/restored.

Kevin
