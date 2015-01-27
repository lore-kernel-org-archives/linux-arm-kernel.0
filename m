From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 00:14:19 +0000
Subject: [PATCH 00/18] spi/xilinx: Speed-up
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150127001419.GO21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:08:32PM +0100, Ricardo Ribalda Delgado wrote:
> This set of patches has been developed after using the core to access a spi
> nor flash. The initial performance was not as desired. The following changes
> have been done.

In general the best way to present a series is to start off with any bug
fixes (so they can be sent to Linus and stable if needed), then move on
to mechanical and stylistic cleanups (since they tend to be easy to
review and apply) and finally move on to new functionality (since that
is most likely to run into review problems and the cleanups should help
review).  

>   spi/xilinx: Support for spi mode LOOP
>   spi/xilinx: Simplify data read from the Rx FIFO
>   spi-xilinx: Simplify spi_fill_tx_fifo

spi-xilinx?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/416c9153/attachment-0001.sig>
