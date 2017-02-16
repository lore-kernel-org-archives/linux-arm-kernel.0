From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 16 Feb 2017 11:14:10 +0800
Subject: [PATCH 1/4] Documentation: bindings: add uphy-dp-sel for Rockchip
 USB Type-C PHY
In-Reply-To: <20170216022016.ubspejlr7no7ttgl@rob-hp-laptop>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
 <1486712654-15431-2-git-send-email-zyw@rock-chips.com>
 <20170216022016.ubspejlr7no7ttgl@rob-hp-laptop>
Message-ID: <58A51902.5040508@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

On 02/16/2017 10:20 AM, Rob Herring wrote:
> On Fri, Feb 10, 2017 at 03:44:11PM +0800, Chris Zhong wrote:
>> rockchip,uphy-dp-sel is the register of type-c phy enable DP function.
> "dt-bindings: phy:" is the preferred subject prefix.
OK, I will change the header next version.
dt-bindings: phy: add uphy-dp-sel for Rockchip USB Type-C PHY.

>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>> ---
>>
>>   Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 5 +++++
>>   1 file changed, 5 insertions(+)
> Otherwise,
>
> Acked-by: Rob Herring <robh@kernel.org>
>
>
>
