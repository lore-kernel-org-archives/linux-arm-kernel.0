From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 22 Jul 2011 12:14:15 -0300
Subject: [patch 1/3] imx51: add pata device
In-Reply-To: <20110722103832.403681566@rtp-net.org>
References: <20110722103710.226100346@rtp-net.org>
	<20110722103832.403681566@rtp-net.org>
Message-ID: <CAOMZO5Cx2Bkz2HGVV5JT2ietT1c4bvt9583FT8iorwsrAN_ZFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 7:37 AM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
...
> +#define imx_mxc_pata_data_entry_single(soc) ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? ? ? ? ? .iobase = soc ## _ATA_BASE_ADDR, ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ? ? ? ? .irq = soc ## _MXC_INT_ATA, ? ? ? ? ? ? ? ? ? ? ? ? ? ? \

Why not imx_pata_data_entry_single instead?

 "imx_mxc" looks redundant.

Regards,

Fabio Estevam
