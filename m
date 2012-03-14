From: b32955@freescale.com (Huang Shijie)
Date: Wed, 14 Mar 2012 15:58:23 +0800
Subject: [PATCH v1 5/5] ARM: mxs: add mxs dma dt support
In-Reply-To: <1331628428-24017-6-git-send-email-b29396@freescale.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-6-git-send-email-b29396@freescale.com>
Message-ID: <4F604F9F.1070801@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> +			dma-apbh at 80004000 {
> +				compatible = "fsl,mxs-dma-apbh";
> +				reg =<0x80004000 2000>;
> +			};
> +
Why you do not add the `interrupt` for the it?
the gpmi-nand needs to parse the interrupt out.

BR
Huang Shijie
