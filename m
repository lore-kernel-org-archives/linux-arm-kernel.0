From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 18 May 2012 16:29:46 +0530
Subject: [PATCH] ARM: OMAP2+: fix gpmc request_irq
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98DEEA@DBDE01.ent.ti.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
 <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
 <CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
 <CACVXFVMm5iasFAaBcFhfZskHFwMXEoO2_riP1renR8a0tP_PNg@mail.gmail.com>
 <CAMQu2gz9SGDwE3p1oREb8h+1RUpd1h6yOEJCRJ52PCSY1w0=yQ@mail.gmail.com>
 <CACVXFVOA=EDJR6HqBRRegr13nTnNdjGSvQUwek2jbu41C5euWA@mail.gmail.com>
 <CAMQu2gwzZ7dGW9xMNvTXqB8k3cfJuVF+a2cCVXLn4q92+W3aGQ@mail.gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98DEEA@DBDE01.ent.ti.com>
Message-ID: <CAMQu2gwCr66WLYSAujEH6+cyXdO0s8hoJoSRhKNwz10v6MgwEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 4:21 PM, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Santosh,
>
> On Fri, May 18, 2012 at 15:43:31, Shilimkar, Santosh wrote:
>
>> On the side note, looks like GMPC too needs to be converted
>> to sparse IRQ since it seems to be creating a dummy irqchip
>> and dispatching secondary handlers based on chip selects.
>
> GPMC dummy chip is being modified to so that irq descriptors are created
> dynamically [1], with a final goal of reaching something similar to [2],
> please let me know if any comments on those.
>
Cool. So it's already getting cleaned-up.
Thanks for the reference.

Regards
Santosh
