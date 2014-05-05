From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 14:52:52 -0700
Subject: [PATCH v2 3/3] ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the
 multi_v7_defconfig
In-Reply-To: <1397486478-16991-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397486478-16991-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140505215252.GH29245@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 04:41:18PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 38x platform has a SDHCI interface managed by the
> sdhci-pxav3 MMC host driver. It therefore makes sense to enable this
> driver in multi_v7_defconfig, which supports the Armada 38x platform.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied (this one I had alreayd hunted down before I sent the email
about the other acked multi_v7_defconfig patch. :)

-Olof
