From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 24 Nov 2017 15:46:18 +0100
Subject: [PATCH v2 4/6] ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM
 support
In-Reply-To: <CAOMZO5Brey5G=SM0A143=srmWnLstHaSMrPx-PO5PQc4KtBtBA@mail.gmail.com>
References: <1511348560-28505-1-git-send-email-narmstrong@baylibre.com>
 <1511348560-28505-5-git-send-email-narmstrong@baylibre.com>
 <CAOMZO5CuxBsMv1zabi3JtYyX0wNpv1rZZmZG28BBfo9a155siQ@mail.gmail.com>
 <bbbd71e2-eb31-4d43-7dfc-0ef817c5e13e@baylibre.com>
 <CAOMZO5Brey5G=SM0A143=srmWnLstHaSMrPx-PO5PQc4KtBtBA@mail.gmail.com>
Message-ID: <0d9fe511-392d-74a5-3e65-ef7edd7b8d9b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/2017 15:44, Fabio Estevam wrote:
> Hi Neil,
> 
> On Fri, Nov 24, 2017 at 12:41 PM, Neil Armstrong
> <narmstrong@baylibre.com> wrote:
> 
>>>> +&hdmi {
>>>
>>> No ddc-i2c-bus property?
>>
>> It's in the board dts.
> 
> Yes, I saw it while reviewing the other patch.
> 
> Do different boards use different I2C ports for the HDMI EDID?
> 
> If not, then you could probably put it here instead.

Not at my knowledge, but it's typically something routed on the carrier board.

Anyway I can set it here.

> 
>>>> +&pcie {
>>>> +       fsl,tx-swing-full = <103>;
>>>> +       fsl,tx-swing-low = <103>;
>>>> +       status = "disabled";
>>>
>>> No 'reset-gpio' property?
>>>
>>
>> It will be in the board dts.
> 
> Same here.
> 

Ok.

Neil
