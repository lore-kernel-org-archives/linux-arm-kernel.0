From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 31 Aug 2010 16:48:00 +0200
Subject: [PATCH] ARM: Mark CPU_32v6K as depended on CPU_V7
In-Reply-To: <20100831135126.19953.11529.stgit@e102109-lin.cambridge.arm.com>
References: <20100831135126.19953.11529.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100831144800.GA25102@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 02:52:32PM +0100, Catalin Marinas wrote:
> CPU_32v6K is selected by CPU_V7 but it only depends on CPU_V6.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> 
> It would be nice to have this patch before 2.6.36 is released to avoid a
> warning introduced by my kbuild patch to warn on selecting options with
> unmet dependencies.
ack, too.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
