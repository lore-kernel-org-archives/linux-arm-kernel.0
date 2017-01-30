From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 20:59:24 -0800
Subject: [GIT PULL 3/4] ARM: tegra: Device tree changes for v4.11-rc1
In-Reply-To: <20170127092121.21570-3-thierry.reding@gmail.com>
References: <20170127092121.21570-1-thierry.reding@gmail.com>
 <20170127092121.21570-3-thierry.reding@gmail.com>
Message-ID: <20170130045924.GG18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 10:21:20AM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.11-arm-dt
> 
> for you to fetch changes up to 393a33c74554be3c30233907e3aa0f84603fee31:
> 
>   ARM: tegra: nyan-blaze: Proper pinmux for TPM I2C (2017-01-25 12:07:21 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: Device tree changes for v4.11-rc1
> 
> This contains a set of patches that add hardware compatibility for newer
> revisions of the Toradex Apalis TK1. Also included is a fix to the PAZ00
> that stabilizes panel initialization on boot as well as a patch to add
> card detection for the ??SD card slot on TrimSlice.
> 
> To round things off there are a couple of fixes and changes to the Nyan
> device tree files to fix the battery charger, add compatibility with new
> revisions of Nyan Blaze and Nyan Big, as well as properly support the
> TPM.

Thanks, merged!


-Olof
