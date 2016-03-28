From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Mar 2016 12:09:43 +0200
Subject: [PATCH v6 2/6] power-domain: allow domains only handling idle
 requests
In-Reply-To: <1457558578-22049-3-git-send-email-zhangqing@rock-chips.com>
References: <1457558578-22049-1-git-send-email-zhangqing@rock-chips.com>
 <1457558578-22049-3-git-send-email-zhangqing@rock-chips.com>
Message-ID: <2362699.UXTOZsAcz0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 10. M?rz 2016, 05:22:54 schrieb Elaine Zhang:
> On some Rockchip SoC there exist child-domains only handling their
> idle state with the actual power-state handled by a parent-domain.
> 
> So allow such types of domains. For them, we can determine their
> state (on/of) by checking the inverse idle-state instead.
> 
> There exist one special case if both idle as well power handling
> were set as not present, but as the domain-data is defined in the
> code itself, we can expect the reasonable developer to define them
> 
> So allow such types of domains. For them, we can determine their
> state (on/of) by checking the inverse idle-state instead.
> 
> There exist one special case if both idle as well power handling
> were set as not present, but as the domain-data is defined in the
> code itself, we can expect the reasonable developer to define them
> in a correct, without adding more checks.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied to my armsoc/drivers branch for 4.7


Thanks
Heiko
