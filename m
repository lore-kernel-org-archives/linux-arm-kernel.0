From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 3 Feb 2010 23:15:46 +0100
Subject: [spi-devel-general] PATCH [1/1] SPI: AMBA_PL022: Limit TX FIFO
	fills based on current RX FIFO used
In-Reply-To: <fa686aa41002030948g6359ef3o4c3a7b265490b93f@mail.gmail.com>
References: <083DF309106F364B939360100EC290F805C4BF1E97@eu1rdcrdc1wx030.exi.nxp.com>
	<63386a3d1001220456p484efc7fm811ae2240698cbdf@mail.gmail.com>
	<fa686aa41002030948g6359ef3o4c3a7b265490b93f@mail.gmail.com>
Message-ID: <63386a3d1002031415i4a407b44rfc6ace9ae5ab1c4f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/3 Grant Likely <grant.likely@secretlab.ca>:

> I'm actively maintaining SPI now. ?In general, I'd prefer SPI patches
> to go through the SPI tree, unless there are commit ordering issues
> with arch code.

Sorry, will queue them in your tree next time, and thanks for picking
up SPI.

Yours,
Linus Walleij
