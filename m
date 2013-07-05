From: wangyuhang2014@gmail.com (yuhang wang)
Date: Fri, 5 Jul 2013 17:07:06 +0800
Subject: SPI: DUAL/QUAD support
In-Reply-To: <51D689F3.3070605@ti.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704130017.GA25997@sig21.net>
 <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
 <20130704154927.GE27646@sirena.org.uk>
 <OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
 <CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
 <51D67851.8020402@ti.com>
 <CAHSAbzNvMo_oeaqtzO8-xDm-L-f8wVccVqfuVqbR=OwqWJhVwg@mail.gmail.com>
 <51D689F3.3070605@ti.com>
Message-ID: <CAHSAbzM1PGoMXFNOmB7guDsVWYnRoRy89-bufHYpPz5+odnd8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>                     if (!quad_mode)
>                             dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_SNGL,
>                                             QSPI_SPI_CMD_REG);
>                     else
>                             dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_QUAD,
>                                             QSPI_SPI_CMD_REG);
>                  .......
>                 }

So what do you based on to set variable quad_mode.
