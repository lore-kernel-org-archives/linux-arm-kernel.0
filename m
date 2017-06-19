From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 22:37:48 -0700
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.13
In-Reply-To: <1497383309-14226-5-git-send-email-andy.gross@linaro.org>
References: <1497383309-14226-1-git-send-email-andy.gross@linaro.org>
 <1497383309-14226-5-git-send-email-andy.gross@linaro.org>
Message-ID: <20170619053748.GD7703@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 03:48:28PM -0400, Andy Gross wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.13
> 
> for you to fetch changes up to cff94887d55a32bf8f7095482d9ba92784280a5c:
> 
>   ARM: dts: add core I2C devices to the APQ8060 Dragonboard (2017-06-13 12:23:57 -0400)
> 
> ----------------------------------------------------------------
> Qualcomm Device Tree Changes for v4.13
> 
> * Fix IPQ4019 i2c0 node
> * Add GSBI7 on IPQ8064
> * Add misc APQ8060 devices
> * Fixup USB related devices on APQ8064 and MSM8974
> 
> ----------------------------------------------------------------
> Bird, Tim (1):
>       ARM: dts: qcom: add charger otg regulator
> 
> Christian Lamparter (1):
>       ARM: dts: qcom: ipq4019: fix i2c_0 node
> 
> Linus Walleij (4):
>       ARM: dts: add XOADC and IIO HWMON to MSM8660/APQ8060
>       ARM: dts: Qualcomm APQ8060 DragonBoard ALS sensor
>       ARM: dts: add GSBI8 defines to the MSM8660 family
>       ARM: dts: add core I2C devices to the APQ8060 Dragonboard
> 
> Stephen Boyd (3):
>       ARM: dts: qcom: Remove s4/5vs1,2 from RPM pm8941 control
>       ARM: dts: qcom-msm8974: Add HS usb node and OTG detection mechanisms
>       ARM: dts: qcom-apq8064: Collapse usb support into one node
> 
> Sven Eckelmann (1):
>       ARM: dts: qcom: add gsbi7 serial to ipq8064 SoC device tree

Merged, thanks.


-Olof
