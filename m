From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 09:02:49 +0100
Subject: [PATCH 0/5] Minor fixes for Marvell Armada 38x SoC.
In-Reply-To: <1415835600-97188-1-git-send-email-mw@semihalf.com>
References: <1415835600-97188-1-git-send-email-mw@semihalf.com>
Message-ID: <20141113090249.1ab69b4d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Thu, 13 Nov 2014 00:39:55 +0100, Marcin Wojtas wrote:
> This patchset adds minor fixes for Armada 38x SoC around SDHCI interface. It
> also enables usage of I2C char-device and adjusts ethernet aliases for
> bootloader's needs. Any feedback is welcome.
> 
> Marcin Wojtas (5):
>   ARM: mvebu: re-enable SDHCI driver for Armada 38x SoC in v7 defconfig
>   ARM: mvebu: enable no-1-8-v flag for Armada 385 DB SDHCI interface
>   ARM: mvebu: remove clock-frequency from Armada 38x SDHCI Device Tree
>     node
>   ARM: mvebu: adjust ethernet aliases according to U-Boot requirements
>     for A38x
>   ARM: mvebu: enable i2c device in mvebu_v7_defconfig

On the entire series, you forgot to Cc some of the mvebu maintainers,
namely Andrew Lunn and Sebastian Hesselbarth. I've added them in Cc of
the cover letter, so that they get notified about this patch series.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
