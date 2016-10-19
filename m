From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 19 Oct 2016 08:03:31 -0500
Subject: [PATCH v2 5/9] of: Add vendor prefix for Netron DY
In-Reply-To: <20161019123927.GE16158@ulmo.ba.sec>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-6-maxime.ripard@free-electrons.com>
 <20161019123927.GE16158@ulmo.ba.sec>
Message-ID: <CAL_JsqJmUJRNjxkUx0xkAW9qCgfOQHudMiBtvc2TwyW5DPZM4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 7:39 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Sep 06, 2016 at 04:46:16PM +0200, Maxime Ripard wrote:
>> Netron DY is a brand of LCD panels found on SBCs and tablets.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> Hi Rob,
>
> care to give this your Acked-by?

It helps to send to the DT list.

Acked-by: Rob Herring <robh@kernel.org>

>
> Thanks,
> Thierry
>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 1992aa97d45a..9c1ab3c1132b 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -176,6 +176,7 @@ nec       NEC LCD Technologies, Ltd.
>>  neonode              Neonode Inc.
>>  netgear      NETGEAR
>>  netlogic     Broadcom Corporation (formerly NetLogic Microsystems)
>> +netron-dy    Netron DY
>>  netxeon              Shenzhen Netxeon Technology CO., LTD
>>  newhaven     Newhaven Display International
>>  nintendo     Nintendo
>> --
>> 2.9.3
>>
