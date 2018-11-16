From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Nov 2018 11:15:26 +0100
Subject: [PATCH] clockevents/drivers/tegra20: Remove obsolete inclusion
 of <asm/smp_twd.h>
In-Reply-To: <20181115100037.17706-1-geert+renesas@glider.be>
References: <20181115100037.17706-1-geert+renesas@glider.be>
Message-ID: <20181116101526.GA14769@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:00:37AM +0100, Geert Uytterhoeven wrote:
> As of commit da4a686a2cfb077a ("ARM: smp_twd: convert to use CLKSRC_OF
> init"), this header file is no longer used.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/clocksource/tegra20_timer.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/f74c1647/attachment.sig>
