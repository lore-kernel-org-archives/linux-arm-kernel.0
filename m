From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Wed, 6 Mar 2013 13:54:15 -0300
Subject: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
In-Reply-To: <51377300.3040809@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
 <51360271.1030302@mimc.co.uk> <51360562.20309@ti.com>
 <51361B46.507@mimc.co.uk> <51362BAB.10403@ti.com>
 <513664EC.2050508@ti.com>
 <CALF0-+VeU9tGy-dKgmVg1pT0z0ghJBSsughV7kzT5nX7u=9BhA@mail.gmail.com>
 <51377300.3040809@ti.com>
Message-ID: <CALF0-+W_soY9-ZLO3eS7pTXUTKtcuygJeXkJ3As9U-gkdzabCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 6, 2013 at 1:46 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 03/06/2013 05:58 AM, Ezequiel Garcia wrote:
>> I'll submit this driver by the end of this week, in case you want
>> to take a look at it.
>
> Ok, but this is not for omap right?
>

No, this is a new driver for a memory controller that's available on
some Marvell SoC. It will be located in drivers/memory/.

I don't have any omap boards with a NOR device to test this,
but the discussion and the patches were really helpful!

Thanks,
-- 
    Ezequiel
