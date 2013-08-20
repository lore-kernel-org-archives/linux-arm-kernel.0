From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 20 Aug 2013 16:42:48 -0700
Subject: [GIT PULL 4/4] ARM: tegra: defconfig update for 3.12
In-Reply-To: <1376673628-5867-4-git-send-email-swarren@wwwdotorg.org> (Stephen
 Warren's message of "Fri, 16 Aug 2013 11:20:28 -0600")
References: <1376673628-5867-1-git-send-email-swarren@wwwdotorg.org>
 <1376673628-5867-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <87bo4sj5dz.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> This defconfig change enables:
> * SYSVIPC (needed for some apps, e.g. fakeroot).
> * Elantech touchpad (touchpad on AC100).
> * SCSI_MULTI_LUN (needed for some USB SD card readers).
> * PCI, MSI, and Tegra's PCIe driver.
> * USB XHCI; useful for testing PCIe.
>
> ----------------------------------------------------------------
>
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
>
>   Linux 3.11-rc1
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.12-defconfig
>
> for you to fetch changes up to 25819408cdd8c019277d9b4906ac7345fc1817bd:
>
>   ARM: tegra: defconfig updates

Pulled into next/boards.

Kevin
