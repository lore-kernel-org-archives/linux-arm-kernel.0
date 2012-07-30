From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Jul 2012 17:28:29 +0200
Subject: [PATCH 1/6] Initial csb1724 board support (FDT)
In-Reply-To: <1343661359-10150-2-git-send-email-ian.molton@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-2-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <20120730152829.GJ18016@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian

> diff --git a/arch/arm/configs/csb1724_defconfig b/arch/arm/configs/csb1724_defconfig
> new file mode 100644
> index 0000000..927b269
> --- /dev/null
> +++ b/arch/arm/configs/csb1724_defconfig
> @@ -0,0 +1,47 @@
> +CONFIG_ARCH_KIRKWOOD=y
> +CONFIG_ARCH_KIRKWOOD_DT=y
> +CONFIG_MACH_CSB1724_DT=y

Do you really need this? Its the only kirkwood board with its on
_defconfig file.  What makes this board special?

   Thanks
	Andrew
