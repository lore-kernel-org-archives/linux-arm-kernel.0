From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Jun 2016 15:24:23 -0700
Subject: [GIT PULL 8/8] ARM: defconfig: exynos: Defconfig for v4.8
In-Reply-To: <1465215933-22709-9-git-send-email-k.kozlowski@samsung.com>
References: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
 <1465215933-22709-9-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160613222423.GA29879@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 02:25:33PM +0200, Krzysztof Kozlowski wrote:
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.8
> 
> for you to fetch changes up to 4b388071a2235ed8f05d05d069f5a5a29782a8c5:
> 
>   ARM: exynos_defconfig: Save defconfig on current linux-next (2016-06-06 08:36:55 +0200)
> 
> ----------------------------------------------------------------
> Samsung defconfig update for v4.8:
> 1. Disable big.LITTLE switcher so the cpufreq-dt could be enabled.
> 2. Enable Samsung media platform drivers.
> 3. Enable some board-specific drivers for boards: Trats2, Universal C210.
> 4. Few more minor additions.

Hmm. So this made me wonder what's used on the 5420/5800 chromebooks, but it
looks like they don't even boot with SMP, at least not the way I boot them
(with u-boot as a chainloaded kernel).

Branch merged.


-Olof
