From: nm@ti.com (Nishanth Menon)
Date: Tue, 23 Aug 2016 13:46:20 -0500
Subject: [PATCH 5/5] firmware: ti_sci: Add support for reboot core service
In-Reply-To: <20160823174841.GA23677@rob-hp-laptop>
References: <20160819225159.10758-1-nm@ti.com>
 <20160819225159.10758-6-nm@ti.com>
 <20160823174841.GA23677@rob-hp-laptop>
Message-ID: <CAGo_u6oP2Z-82fj06Kk6Pz1p7e6wyrvvqhWUj8wff_VjeOHdhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 12:48 PM, Rob Herring <robh@kernel.org> wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> index 965d45e313b1..ed5b8fc185f1 100644
>> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> @@ -38,6 +38,7 @@ Optional Properties:
>>  - reg-names:
>>       debug_messages - Map the Debug message region
>>  - reg:  register space corresponding to the debug_messages
>> +- ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
>
> Don't define bindings incrementally. But all the binding in one patch.

Thanks for catching.  Fixed and will post a v2 next week if there is
no further comments.

---
Regards,
Nishanth Menon
