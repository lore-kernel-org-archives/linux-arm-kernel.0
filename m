From: horms@verge.net.au (Simon Horman)
Date: Mon, 13 Mar 2017 10:21:33 +0100
Subject: [PATCH 00/13] arm: dts: renesas: Tidy-up status
In-Reply-To: <1489151956-19270-1-git-send-email-geert+renesas@glider.be>
References: <1489151956-19270-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170313092132.GC19296@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 02:19:03PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series performs some cleanups on the Renesas DT source files:
>   - Patch 1 replaces "ok" by "okay" in statuses, as the latter is the
>     recommended form,
>   - Patches 2-13 drop superfluous status updates when overriding the
>     clock frequencies of fixed-frequency clocks, as they have already
>     been enabled in the SoC-specific DTS file.
> 
> Thanks!

Thanks, applied.
