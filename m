From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 27 Jun 2018 10:46:58 +0200
Subject: [PATCH 1/2] Documentation: dt: keystone: ti-sci: Add optional
 host-id parameter
In-Reply-To: <20180619194421.3432-2-nm@ti.com>
References: <20180619194421.3432-1-nm@ti.com> <20180619194421.3432-2-nm@ti.com>
Message-ID: <CAMuHMdVLLir_U7cu-p=hVv_A1hOuTGhHJRBnad2BYSQdV+rJHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On Tue, Jun 19, 2018 at 9:45 PM Nishanth Menon <nm@ti.com> wrote:
> Texas Instrument's System Control Interface (TISCI) permits
> the ability for OSs running in virtual machines to be able to
> independently communicate with the firmware without the need going
> through an hypervisor.
>
> The "host-id" in effect is the hardware representation of the
> host (example: VMs locked to a core) as identified to the System
> Controller. Hypervisors can either fill in appropriate host-ids in dt
> used for each VM instance OR may use prebuilt blobs where the host-ids
> are pre-populated, as appropriate for the OS running in the VMs.
>
> This is introduced as an optional parameter to maintain consistency
> with legacy device tree blobs.
>
> We call this with a vendor prefix to prevent any possible confusion
> with SCSI ID (m68k) kernel option.

I'd omit the above paragraph. There's no "host-id" literal involved in the
m68k kernel option, and it is not related to DT at all.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
