From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 12:47:22 +0100
Subject: [PATCH v2] multi_v7_defconfig: Remove CONFIG_SOC_LS1021A
In-Reply-To: <1448969745-19743-1-git-send-email-fabio.estevam@freescale.com>
References: <1448969745-19743-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <2978679.eRosYNosdF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 09:35:45 Fabio Estevam wrote:
> multi_v7_defconfig is not suitable for booting LS1021 as it needs
> LPAE.
>     
> Remove this option.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

This needs a better explanation. Why do we need LPAE for this
platform?

	Arnd
