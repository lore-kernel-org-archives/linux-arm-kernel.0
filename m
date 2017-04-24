From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 24 Apr 2017 16:57:45 -0700
Subject: [PATCH 1/2] net: dsa: b53: Add compatible strings for the
 Cygnus-family BCM11360.
In-Reply-To: <8760hte4zw.fsf@eliezer.anholt.net>
References: <20170424215022.30382-1-eric@anholt.net>
 <20170424215022.30382-2-eric@anholt.net>
 <a2f4f0c9-feea-291b-dae5-f4ed10f9c547@broadcom.com>
 <8760hte4zw.fsf@eliezer.anholt.net>
Message-ID: <8054ec9e-73d0-af1a-bb9a-fcdac782dc9c@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17-04-24 04:54 PM, Eric Anholt wrote:
> Scott Branden <scott.branden@broadcom.com> writes:
>
>> Minor comment in line
>>
>> On 17-04-24 02:50 PM, Eric Anholt wrote:
>>> Cygnus is a small family of SoCs, of which we currently have
>>> devicetree for BCM11360 and BCM58300.  The 11360's B53 is mostly the
>>> same as 58xx, just requiring a tiny bit of setup that was previously
>>> missing.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>> ---
>>>  Documentation/devicetree/bindings/net/dsa/b53.txt | 3 +++
>>>  drivers/net/dsa/b53/b53_srab.c                    | 2 ++
>>>  2 files changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/dsa/b53.txt b/Documentation/devicetree/bindings/net/dsa/b53.txt
>>> index d6c6e41648d4..49c93d3c0839 100644
>>> --- a/Documentation/devicetree/bindings/net/dsa/b53.txt
>>> +++ b/Documentation/devicetree/bindings/net/dsa/b53.txt
>>> @@ -29,6 +29,9 @@ Required properties:
>>>        "brcm,bcm58625-srab"
>>>        "brcm,bcm88312-srab" and the mandatory "brcm,nsp-srab string
>>>
>>> +  For the BCM11360 SoC, must be:
>>> +      "brcm,bcm11360-srab" and the mandatory "brcm,cygnus-srab string
>>> +
>> place in alphabetical order in the doc?
>
> Moved it above BCM5310x now.  I hope that's what you meant.
>
Yes, sorry for not being more clear.
