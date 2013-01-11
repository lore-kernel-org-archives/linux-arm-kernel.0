From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Jan 2013 10:47:37 +0100
Subject: [PATCH v7 0/3] Yet another update for the Cortex-M3 series
In-Reply-To: <1350462872-16805-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1350462872-16805-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130111094737.GF14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Wed, Oct 17, 2012 at 10:34:29AM +0200, Uwe Kleine-K?nig wrote:
> the only change since v6 is a rebase on top of v3.7-rc1 and so on Al
> Viro's changes to kernel_execve().
> 
> These patches merge just fine into today's next and I put them into my
> branch that Stephen will pick for the next next.
> 
> As before this doesn't make a functional M3 port as there are still some
> missing items. If you want to see the code live I also updated the efm32
> branch in my repository to be based on these patches. This code works,
> but isn't suitable for mainline yet. You can run it on EnergyMicro's
> efm32 devboard.
> 
> Best regards
> Uwe
> 
> Catalin Marinas (1):
>   Cortex-M3: Add base support for Cortex-M3
> 
> Uwe Kleine-K?nig (2):
>   ARM: make cr_alignment read-only #ifndef CONFIG_CPU_CP15
>   Cortex-M3: Add support for exception handling
These patches are in next since next-20121018 without any reported
problems. What do you think about inclusion for 3.9-rc1?

They are based on 3.7-rc1 and I'm currently porting my tree to 3.8-rc3
to test there.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
