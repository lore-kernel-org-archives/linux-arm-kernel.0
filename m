From: b32955@freescale.com (Huang Shijie)
Date: Wed, 4 Dec 2013 10:46:06 +0800
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <5298AA23.7080404@st.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com>
Message-ID: <529E976E.4050104@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?11?29? 22:52, Angus Clark ??:
> 	int (*write_reg)(struct spi_nor_info *info,
> 			 uint8_t cmd, uint8_t *reg, int len,
> 			 int wren, int wtr);
I guess you add the 'wren' for the issuing write-enable before issuing 
the 'cmd'.

but what's 'wtr' for? i do not know what's the meaning of the 'wtr'.

thanks
Huang Shijie
