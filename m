From: b32955@freescale.com (Huang Shijie)
Date: Tue, 27 Aug 2013 14:02:01 +0800
Subject: [PATCH] ARM: i.MX6: dts: change iomuxc pinctrl config to match
 Rev. 0 IMX6DQRM
In-Reply-To: <1377495568-9368-1-git-send-email-alison_chaiken@mentor.com>
References: <1377495568-9368-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <521C40D9.3070802@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?08?26? 13:39, alison_chaiken at mentor.com ??:
> From: Alison Chaiken <alison_chaiken@mentor.com>
>
> Update imx6.dtsi iomuxc pinctrl config settings to reflect Table 4-1 of Rev. 0
> (11/2012) of IMX6DQRM, i.MX6 technical reference manual.
>
> Impact:
> USDHC: increase drive speed and impedance.
> I2C and EIM: change drive impedance and disable open-drain.
> ECSPI: change drive impedance.
> ESAI and ENET: probably pedantic changes.
Could you rebase this patch with the latest code? linux-next?


thanks
Huang Shijie
