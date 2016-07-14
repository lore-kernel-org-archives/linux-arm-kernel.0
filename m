From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 14 Jul 2016 21:26:20 +0800
Subject: [PATCH v3 0/3] Complete ZTE PL011 device support
In-Reply-To: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20160714132620.GB4382@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 05:00:38PM +0800, Shawn Guo wrote:
> This is a pick-up of Jun's v2 patch which tries to complete ZTE PL011
> support.
> 
> Commit 7ec758718920 ("tty: amba-pl011: add support for ZTE UART
> (EXPERIMENTAL)") from Russell had already done part of the work that is
> needed for ZTE PL011 support.  The series adds the missing pieces which
> includes handling Flag Register bit position oddness and getting ZTE
> PL011 device probed by amba-pl011 driver.
> 
> Thanks to Russell for the "official" pseudo-ID idea.
> 
> Changes since v2:
>  - Split changes into 3 separate patches
>  - Take Russell's suggestion using helper macro to create pseudo-ID
>  - Rebase to v4.7-rc6
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/417192.html
> 
> Shawn Guo (3):
>   tty: amba-pl011: define flag register bits for ZTE device
>   tty: amba-pl011: add .get_fifosize for ZTE device
>   tty: amba-pl011: probe ZTE device from AMBA bus with a pseudo-ID

Hi Russell,

Most of the changes of patch #3 are yours, so presumably you are fine
with it.  What about #1 and #2?  May I have your ACK on them, so that I
can ask Greg to pick up the series?  Thanks.

Shawn
