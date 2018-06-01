From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Jun 2018 14:02:17 -0500
Subject: [PATCH 2/3] clk: bcm: Update and add tingray clock entries
In-Reply-To: <a354f3d1-051d-8b68-e6b3-ce7a739c10c9@broadcom.com>
References: <1527266717-8406-1-git-send-email-ray.jui@broadcom.com>
 <1527266717-8406-3-git-send-email-ray.jui@broadcom.com>
 <20180531162556.GA955@rob-hp-laptop>
 <a354f3d1-051d-8b68-e6b3-ce7a739c10c9@broadcom.com>
Message-ID: <CAL_Jsq+YX01CwCycqeu5mxTUiWtnG3HKPJP5mvJO2OHcPF6v6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 1, 2018 at 12:56 PM, Ray Jui <ray.jui@broadcom.com> wrote:
> Hi Rob,
>
> On 5/31/2018 9:25 AM, Rob Herring wrote:
>>
>> On Fri, May 25, 2018 at 09:45:16AM -0700, Ray Jui wrote:
>>>
>>> Update and add Stingray clock definitions and tables so they match the
>>> binding document and the latest ASIC datasheet
>>>
>>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>> ---
>>>   drivers/clk/bcm/clk-sr.c           | 135
>>> ++++++++++++++++++++++++++++++++-----
>>>   include/dt-bindings/clock/bcm-sr.h |  24 +++++--
>>
>>
>> This goes in the 1st patch.
>
>
> Please help to confirm. You want 1st patch and 2nd patch to be combined into
> a single patch?

No. include/dt-bindings/* is part of the DT binding, so it goes with
patch 1. The driver in patch 2.

Rob
