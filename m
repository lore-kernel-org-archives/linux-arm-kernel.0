From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 15:00:36 -0800
Subject: [GIT PULL 3/3] ARM: imx: defconfig updates for 4.5
In-Reply-To: <1450795558-10961-3-git-send-email-shawnguo@kernel.org>
References: <1450795558-10961-1-git-send-email-shawnguo@kernel.org>
 <1450795558-10961-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20151222230036.GQ30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 10:45:58PM +0800, Shawn Guo wrote:
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.5
> 
> for you to fetch changes up to 31e98e0d24cd2537a63e06e235e050a06b175df7:
> 
>   ARM: imx_v6_v7_defconfig: enable PCI_MSI (2015-12-02 21:28:32 +0800)
> 
> ----------------------------------------------------------------
> The i.MX defconfig updates for 4.5:
> - Drop CONFIG_SOC_LS1021A support, as it needs LPAE which is not
>   available with imx_v6_v7_defconfig.
> - Enable VF610_ADC, HDMI audio and PCI_MSI support

Merged, thanks.


-Olof
