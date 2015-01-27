From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 11:59:53 +0000
Subject: [PATCH 00/18] spi/xilinx: Speed-up
In-Reply-To: <CAPybu_1==6gvwbWQWxSj_C3siGFTjvqNh1=Xj6jvu_xQFOA-Kw@mail.gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <20150127001419.GO21293@sirena.org.uk>
 <CAPybu_1==6gvwbWQWxSj_C3siGFTjvqNh1=Xj6jvu_xQFOA-Kw@mail.gmail.com>
Message-ID: <20150127115953.GQ21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 11:17:42AM +0100, Ricardo Ribalda Delgado wrote:
> On Tue, Jan 27, 2015 at 1:14 AM, Mark Brown <broonie@kernel.org> wrote:

> >>   spi/xilinx: Support for spi mode LOOP
> >>   spi/xilinx: Simplify data read from the Rx FIFO
> >>   spi-xilinx: Simplify spi_fill_tx_fifo

> > spi-xilinx?

> Thanks! Fixed on the next version.

> BTW what is preferred spi/xilinx: or spi: xilinx: ?I have seen both naming.

Traditionally SPI always used spi/xilinx but that's too far out from the
normal kernel standards so it's hard to get people to follow it at all
so I don't worry about that specific bit too much.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/de83855e/attachment-0001.sig>
