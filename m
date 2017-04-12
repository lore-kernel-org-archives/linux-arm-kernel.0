From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Apr 2017 10:56:08 +0200
Subject: [PATCH 4/7] arm64: marvell: dts: add crypto engine description
 for 7k/8k
In-Reply-To: <20170329124432.27457-5-antoine.tenart@free-electrons.com>
References: <20170329124432.27457-1-antoine.tenart@free-electrons.com>
 <20170329124432.27457-5-antoine.tenart@free-electrons.com>
Message-ID: <20170412105608.41501b63@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 29 Mar 2017 14:44:29 +0200, Antoine Tenart wrote:

> +			cpm_crypto: crypto at 800000 {
> +				compatible = "inside-secure,safexcel-eip197";
> +				reg = <0x800000 0x200000>;
> +				interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH)>,

Now that I look into this, does it makes sense for an interrupt to be
both an edge interrupt and a level interrupt at the same time? This
looks odd.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
