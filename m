From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 26 Feb 2018 11:38:05 +0530
Subject: [PATCH] ARM: davinci: board-da830-evm: fix unused const variable
 warning
In-Reply-To: <20180119145129.16818-1-nsekhar@ti.com>
References: <20180119145129.16818-1-nsekhar@ti.com>
Message-ID: <00cc2c53-f2f1-4631-243b-e2370b9679e4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 January 2018 08:21 PM, Sekhar Nori wrote:
> da830_evm_emif25_pins[] is used only when CONFIG_DA830_UI_NAND
> is enabled. It gives the following warning when the config is
> switched off. Fix it.
> 
> arch/arm/mach-davinci/board-da830-evm.c:245:20: warning: ?da830_evm_emif25_pins? defined but not used [-Wunused-const-variable=]
>  static const short da830_evm_emif25_pins[] = {
>                     ^~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Added to v4.17/soc of my tree.

Thanks,
Sekhar
