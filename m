From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 09 Sep 2011 22:34:14 +0530
Subject: [PATCH 5/5] ARM: omap4: Kill private do_wfi macro.
In-Reply-To: <1315582012-23507-6-git-send-email-nbowler@elliptictech.com>
References: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
	<1315582012-23507-6-git-send-email-nbowler@elliptictech.com>
Message-ID: <4E6A470E.9010703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 September 2011 08:56 PM, Nick Bowler wrote:
> The do_wfi macro duplicates the functionality of the wfi macro in common
> ARM code.  Use the common version instead.
>
> Signed-off-by: Nick Bowler<nbowler@elliptictech.com>
> ---
> Compile tested in both ARM and Thumb-2 mode.

Thanks but this is already handle in my PM series.

https://patchwork.kernel.org/patch/624761/

Regards
Santosh
