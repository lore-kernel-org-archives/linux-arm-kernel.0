From: jhnikula@gmail.com (Jarkko Nikula)
Date: Mon, 14 Mar 2011 15:55:42 +0200
Subject: [PATCH] omap3: alsa-soc: Remove restrictive check for cpu type
In-Reply-To: <1300109513-29002-1-git-send-email-premi@ti.com>
References: <1300109513-29002-1-git-send-email-premi@ti.com>
Message-ID: <20110314155542.b60bd852.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Mar 2011 19:01:53 +0530
Sanjeev Premi <premi@ti.com> wrote:

> Current check for cpu type is too restrictive leading to
> failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
There are two other cpu_is_omap343x tests as well. Care to check them
too?

-- 
Jarkko
