From: markus.mayer@linaro.org (Markus Mayer)
Date: Mon, 19 Aug 2013 15:31:25 -0700
Subject: [PATCH v4 3/3] ARM: bcm281xx: Device Tree bindings for GPIO driver
In-Reply-To: <7172097.b0dioE2CoB@flatron>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-4-git-send-email-markus.mayer@linaro.org>
 <7172097.b0dioE2CoB@flatron>
Message-ID: <CAPdLdq=1-sf0ODyRuONTU4RrnTPzgCLpWrkqzcMu+WHZP7B4zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 August 2013 14:45, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Markus,
>
> The patch looks good overall, just a little nitpick about the commit
> message.
>
> On Monday 19 of August 2013 11:59:21 Markus Mayer wrote:
>> GPIO device tree bindings for the Broadcom bcm281xx family of chips
>
> Device tree bindings are sets of properties and subnodes defined for
> device nodes used to describe those devices. In other words, bindings are
> what you have described in numerous files
> Documentation/devicetree/bindings.
>
> What this patch is adding is a device node for the GPIO controller of
> bcm11351.
>
> Other than that:
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Thanks. Does this look okay?

-----
ARM: bcm281xx: Add device node for the GPIO controller

Add the GPIO controller device node for the Broadcom bcm281xx family of
chips
-----

bcm11351 is one flavour of the bcm281xx family (long story why the
numbers look completely different), so I'd rather use that in the
description.

Regards,
-Markus

-- 
Markus Mayer
Broadcom Landing Team
