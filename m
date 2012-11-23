From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Nov 2012 11:17:41 +0100
Subject: [PATCHv2] ARM: dts: cfa10049: Add PCA9555 GPIO expander to the
 device tree
In-Reply-To: <1353422015-4790-1-git-send-email-maxime.ripard@free-electrons.com>
References: <20121120144322.GE4882@S2100-06.ap.freescale.net>
 <1353422015-4790-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50AF4D45.1090507@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Le 20/11/2012 15:33, Maxime Ripard a ?crit :
> Add the GPIO expander found on the i2c1 bus, behind the muxer to the
> device tree.
> 
> This gpio expander will be used to get tachymeters values and data ready
> interruptions from the nuvoton NAU7802 ADCs.

Since this patch depends on the I2C muxer patches you applied, can you
take it to push it for 3.8? Shawn Guo is ok with it, but it doesn't
apply in his tree.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
