From: cjb@laptop.org (Chris Ball)
Date: Sun, 20 Oct 2013 22:12:45 -0400
Subject: [PATCH v3 0/8] mmc: sdhci-esdhc-imx: add std tuning for mx6sl and
 DDR mode support
In-Reply-To: <1382096930-7964-1-git-send-email-b29396@freescale.com> (Dong
 Aisheng's message of "Fri, 18 Oct 2013 19:48:42 +0800")
References: <1382096930-7964-1-git-send-email-b29396@freescale.com>
Message-ID: <87sivv8j8i.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Fri, Oct 18 2013, Dong Aisheng wrote:
> The i.MX6SL supports standard tuning as defined in standard host control spec v3.0.
> So this patch series add std tuning support for i.MX6SL.
> (NOTE i.MX6SL can also work on the old manual tuning mode as i.MX6Q/DL)
> In the meanwhile, it also adds DDR mode support.
> Then SD3.0 cards which can only support DDR50 can work properly now
> with this patch series.
>
> Patch 1~3 add stardard tuning support for i.MX6SL.
> Patch 4~5 add DDR mode and delay line support
> Patch 6~8 some other related minor fixes.
>
> Tested on i.MX6SL EVK board.
>
> The patch series is generated based on the latest mmc-next branch with Shawn's
> (1)[PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type in Chris' tree.

Thanks, all eight patches pushed to mmc-next for 3.13 with Shawn's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
