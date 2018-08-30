From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2018 16:12:15 +0200
Subject: [PATCH] ARM: shmobile: defconfig: Refresh shmobile_defconfig for
 v4.19-rc1
In-Reply-To: <20180828145646.12014-1-geert+renesas@glider.be>
References: <20180828145646.12014-1-geert+renesas@glider.be>
Message-ID: <20180830141214.xi7xw2tfgqjnhjbf@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 04:56:46PM +0200, Geert Uytterhoeven wrote:
> Refresh the defconfig for Renesas ARM boards:
>   - Move options that have moved,
>   - Remove CONFIG_HAVE_ARM_ARCH_TIMER (auto-enabled),
>   - Remove ENABLE_WARN_DEPRECATED (removed).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert, applied for v4.20.
