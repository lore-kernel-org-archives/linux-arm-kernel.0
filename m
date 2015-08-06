From: olof@lixom.net (Olof Johansson)
Date: Thu, 6 Aug 2015 10:15:14 +0200
Subject: [PATCH 1/2] arm64: Enable Marvell Berlin SoC family in Kconfig
In-Reply-To: <1438629886-6390-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1438629886-6390-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1438629886-6390-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20150806081514.GF16520@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 09:24:45PM +0200, Sebastian Hesselbarth wrote:
> From: Jisheng Zhang <jszhang@marvell.com>
> 
> This patch introduces ARCH_BERLIN to enable Marvell Berlin SoC family in
> Kconfig.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> As discussed with Olof on IRC, this is Jisheng's Kconfig patch for
> ARM64 Berlin. Olof agreed to rework this to finally land in
> Kconfig.platforms, i.e. after
>   eed6b3eb20b9 ("arm64: Split out platform options to separate Kconfig")

Applied, thanks.


-Olof
