From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Apr 2017 15:00:56 -0700
Subject: [PATCH 1/2] dt/bindings: Add bindings for Broadcom STB DRAM
 Sensors
In-Reply-To: <20170427215737.dmnj4u2e4tfc6vfv@rob-hp-laptop>
References: <20170418201702.57019-1-code@mmayer.net>
 <20170418201702.57019-2-code@mmayer.net>
 <CAGt4E5susQWWNZPbNh8AoWtK-4yu50VL=GqOw+_2w_FA+2V68Q@mail.gmail.com>
 <CAGt4E5uu1Ty0ReaiBZ0kcR_-jnqJQL8vgU4Y9mL64FP7f+=T7Q@mail.gmail.com>
 <20170427215737.dmnj4u2e4tfc6vfv@rob-hp-laptop>
Message-ID: <90f011d6-9241-e860-7a0e-2fb52c2337ce@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2017 02:57 PM, Rob Herring wrote:
>>>> +  - reg: must reference the start address and length of the DCPU register
>>>> +    space
>>>> +
>>>> +Optional properties:
>>>> +  - cell-index: the index of the DPFE instance; will default to 0 if not set
> 
> Don't use cell-index. It's not a valid property for FDT (only real 
> OpenFirmware).

My bad, I was advising Markus to use this property since it was largely
used throughout Documentation/devicetree/bindings/. What would be a more
appropriate way to have the same information? Aliases?
-- 
Florian
