From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 18 May 2012 15:40:02 +0800
Subject: [PATCH] ARM: OMAP2+: fix gpmc request_irq
In-Reply-To: <CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
 <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
 <CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
Message-ID: <CACVXFVMm5iasFAaBcFhfZskHFwMXEoO2_riP1renR8a0tP_PNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 18, 2012 at 3:19 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> :
>>> Are you sure it fails ?

[    1.778930] GPMC revision 6.0
[    1.782226] gpmc: irq-52 could not claim: err -22


> Thanks for the reference. removing SHARED flag is not solution and
> yes, you might have to keep the dev-id if that was the issue.

Is the gpmc a shared interrupt line? SHARED is not needed at all for
non shared interrupt line in hardware.

Thanks,
--
Ming Lei
