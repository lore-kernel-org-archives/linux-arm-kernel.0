From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 15 May 2017 10:37:53 +0530
Subject: [PATCH 02/11] dt-bindings: clk: Extend binding doc for Stingray
 SOC
In-Reply-To: <20170512152134.tjuc5exo4plalujs@rob-hp-laptop>
References: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
 <1494071686-19098-3-git-send-email-anup.patel@broadcom.com>
 <20170512152134.tjuc5exo4plalujs@rob-hp-laptop>
Message-ID: <CAALAos-5wd6qPvvZqezswsBXm=n1UJhB9kFkoYeanT-RwaXW1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 8:51 PM, Rob Herring <robh@kernel.org> wrote:
> On Sat, May 06, 2017 at 05:24:37PM +0530, Anup Patel wrote:
>> From: Sandeep Tripathy <sandeep.tripathy@broadcom.com>
>>
>> Update iproc clock dt-binding documentation with
>> Stingray pll and clock details.
>>
>> Signed-off-by: Sandeep Tripathy <sandeep.tripathy@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  .../bindings/clock/brcm,iproc-clocks.txt           | 76 ++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
>> index 6f66e9a..f2c5f0e4a 100644
>> --- a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
>> +++ b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
>> @@ -219,3 +219,79 @@ BCM63138
>>  --------
>>  PLL and leaf clock compatible strings for BCM63138 are:
>>      "brcm,bcm63138-armpll"
>> +
>> +Stingray
>> +-----------
>> +PLL and leaf clock compatible strings for Stingray are:
>> +    "brcm,sr-genpll0"
>> +    "brcm,sr-genpll1"
>> +    "brcm,sr-genpll2"
>> +    "brcm,sr-genpll3"
>> +    "brcm,sr-genpll4"
>> +    "brcm,sr-genpll5"
>> +    "brcm,sr-genpll6"
>> +
>> +    "brcm,sr-lcpll0"
>> +    "brcm,sr-lcpll1"
>> +    "brcm,sr-lcpll-pcie"
>> +
>> +
>> +The following table defines the set of PLL/clock index and ID for Stingray.
>> +These clock IDs are defined in:
>> +    "include/dt-bindings/clock/bcm-sr.h"
>
> This header should be part of this commit. With that,

Sure, I will include bcm-sr.h as-part of this commit.

>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,
Anup
