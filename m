From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Nov 2013 14:24:15 -0800
Subject: [PATCH] arm: ep93xx: use soc bus
In-Reply-To: <1384816986-3744-1-git-send-email-rmallon@gmail.com>
References: <1384816986-3744-1-git-send-email-rmallon@gmail.com>
Message-ID: <20131125222415.GB18365@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 10:23:06AM +1100, Ryan Mallon wrote:
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> Use the soc bus to report the silicon revision and Maverick Key. Both
> are not currently exposed to the user. In addition, fill in the SoC
> family and machine for completeness.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Acked-by: Ryan Mallon <rmallon@gmail.com>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-ep93xx/Kconfig                 |    1 +
>  arch/arm/mach-ep93xx/core.c                  |  108 +++++++++++++++++++++++++-
>  arch/arm/mach-ep93xx/include/mach/platform.h |    3 +-
>  3 files changed, 110 insertions(+), 2 deletions(-)

Applied to next/soc. Thanks!


-Olof
