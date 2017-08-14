From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 14 Aug 2017 13:17:21 +0200
Subject: [PATCH] dt-bindings: watchdog: mediatek: add support for MediaTek
 MT7623 and MT7622 SoC
In-Reply-To: <1502418991.19230.1.camel@mtkswgap22>
References: <b0058a0a9f948f17edf3c1a476665c715922ebc3.1501830388.git.sean.wang@mediatek.com>
 <20170810174343.7pejhh7wxkcaf3zj@rob-hp-laptop>
 <1502418991.19230.1.camel@mtkswgap22>
Message-ID: <6f81355c-8071-1fc2-fe07-20dfef28e80e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/11/2017 04:36 AM, Sean Wang wrote:
> On Thu, 2017-08-10 at 12:43 -0500, Rob Herring wrote:
>> On Fri, Aug 04, 2017 at 03:14:07PM +0800, sean.wang at mediatek.com wrote:
>>> From: Sean Wang <sean.wang@mediatek.com>
>>>
>>> This updates dt-binding documentation for MediaTek MT7622 and
>>> MT7623 SoC. For the both SoCs supported all rely on the fallback
>>> binding of the case with "mediatek,mt6589-wdt".
>>>
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> ---
>>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 2 ++
>>>   1 file changed, 2 insertions(+)
>>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Hi, Rob
> 
> thanks a lot
> 
> can the patch go through your tree?
> 

 From the MAINTAINERS file:
WATCHDOG DEVICE DRIVERS
M:      Wim Van Sebroeck <wim@iguana.be>
R:      Guenter Roeck <linux@roeck-us.net>
L:      linux-watchdog at vger.kernel.org
W:      http://www.linux-watchdog.org/
T:      git git://www.linux-watchdog.org/linux-watchdog.git
S:      Maintained
F:      Documentation/devicetree/bindings/watchdog/
F:      Documentation/watchdog/
F:      drivers/watchdog/
F:      include/linux/watchdog.h
F:      include/uapi/linux/watchdog.h

The best will be to resend and add the email addresses/lists

Regards,
Matthias
