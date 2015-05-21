From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 21 May 2015 16:09:39 +0200
Subject: [PATCH 2/2] doc: dt: add documentation for nxp,
 lpc1850-usb-otg-phy
In-Reply-To: <555DD6C8.7040804@ti.com>
References: <1431797277-4906-1-git-send-email-manabian@gmail.com>
 <1431797277-4906-3-git-send-email-manabian@gmail.com>
 <555DD6C8.7040804@ti.com>
Message-ID: <CAGhQ9VyDvQHPfaU0k8GbKka1Sv3Ni0SXy2ZmusyChr4r4yA-Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 21 May 2015 at 14:59, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
> On Saturday 16 May 2015 10:57 PM, Joachim Eastwood wrote:
>>
>> Add binding documentation for nxp,lpc1850-usb-otg-phy. This PHY
>
>
> %s/nxp,lpc1850-usb-otg-phy/NXP LPC18xx/43xx USB OTG PHY

Sure.

>>
>> can found on NXP LPC18xx and LPC43xx devices.
>
>
> Fix $subject to something like 'dt_bindings: Add NXP LPC18xx/43xx USB OTG
> PHY bindings'

okey.

>>
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>   .../bindings/phy/nxp,lpc1850-usb-otg-phy.txt          | 19
>> +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt
>> b/Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt
>> new file mode 100644
>> index 000000000000..3da60ca04a42
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt
>
>
> phy-lpc18xx-usb-otg.txt?

Fine by me.

Thanks for your comments, Kishon.


regards,
Joachim Eastwood
