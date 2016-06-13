From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Jun 2016 14:53:39 -0700
Subject: [GIT PULL 7/8] ARM: dts: exynos: Topic branch with Odroid XU for
 v4.8
In-Reply-To: <1465215933-22709-8-git-send-email-k.kozlowski@samsung.com>
References: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
 <1465215933-22709-8-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160613215339.GE20845@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 02:25:32PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> This topic branch pulls external clk dependency (provided by Sylwester
> Nawrocki).
> 
> Expected annoying conflict with DT changes here (please see the email 0/8).
> 
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-odroid-xu-4.8
> 
> for you to fetch changes up to b8bd7e23bb0be762c39510497c931066dc62e62f:
> 
>   ARM: dts: exynos: Add watchdog and Security SubSystem to Exynos5410 (2016-06-06 13:20:57 +0200)
> 
> ----------------------------------------------------------------
> Topic branch for adding Exynos 5410 Odroid XU board for v4.8.
> 
> This brings support for Hardkernel's Odroid XU board.  It was the first
> design with big.LITTLE SoC from Samsung: Exynos5410.  The board is not
> very popular.  Newer XU3 and XU4 got more attention.
> 
> Board details:
> 1. Exynos5410 octa-core (A15+A7, however as of now only one cluster is
>    enabled),
> 2. 2 GB DDR3 RAM,
> 3. PowerVR SGX544MP3 GPU (not enabled in DTS),
> 4. USB 3.0 Host x 1, USB 3.0 OTG x 1, USB 2.0 Host x 4,
> 5. HDMI 1.4a, MIPI DSI and Display Port (Display Port not on all of
>    revisions though),
> 6. eMMC 4.5 and microSD slots.

Merged. Please double-check conflict resolution but it seemed trivial
(reapplied "ARM: dts: exynos: Add async-bridge clock to MFC power domain
for Exynos5420" to the new context).


-Olof
