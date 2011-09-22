From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 22 Sep 2011 11:23:34 +0530
Subject: [PATCH v16 07/12] OMAP: dmtimer: add timeout to low-level routines
In-Reply-To: <20110922010046.GS2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-8-git-send-email-tarun.kanti@ti.com>
	<20110922010046.GS2937@atomide.com>
Message-ID: <CAC83Zv+zg1LURpvRLc96sVV4sEx2CG7=1Lt+dT1VvhqEHAkj0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Let's leave out these changes for now, they make the
> omap2_gp_timer_set_next_event used for system timer interrupts
> huge if you take a look at it with objdump.
>
> Later on we might want to split the posted bit check into a separate
> inline function, and then you can implement this for the device
> driver where things are more likely to go wrong with more complicated
> use scenarios.
Alright.
--
Tarun
>
> Regards,
>
> Tony
>
>
