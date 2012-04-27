From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 Apr 2012 14:15:12 -0700
Subject: [PATCH] arm: omap3: Only access IVA if one exists
In-Reply-To: <1334859465-14352-1-git-send-email-mgreer@animalcreek.com> (Mark
 A. Greer's message of "Thu, 19 Apr 2012 11:17:45 -0700")
References: <1334859465-14352-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <87bomc27xb.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> prcm_setup_regs() blindly accesses IVA bits
> in the PRM and calls omap3_iva_idle() which
> does more IVA related register accesses.
> Only do this if the IVA hardware actually
> exists.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Thanks, queuing for v3.5 (branch: for_3.5/cleanup/pm)

Kevin
