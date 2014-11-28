From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 16:08:34 +0100
Subject: [PATCH v2 RESEND 1/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
References: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
Message-ID: <201411281608.34978.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014, Pawel Moll wrote:
> Now, with the CLCD DT support available, there is no
> more reason to keep the non-DT support for V2P-CA9.
> 
> Removed, together with "some" supporting code. It was
> necessary to make PLAT_VERSATILE_SCHED_CLOCK optional
> and selected by the machines still interested in it.
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> Changes since v1:
> 
> - Removed MFD and power/reset changes from the patch;
>   will be posted separately after this is merged.

Applied to next/cleanup, thanks!

	Arnd
