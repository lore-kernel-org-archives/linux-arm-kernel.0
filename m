From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Tue, 27 Jan 2015 11:17:42 +0100
Subject: [PATCH 00/18] spi/xilinx: Speed-up
In-Reply-To: <20150127001419.GO21293@sirena.org.uk>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <20150127001419.GO21293@sirena.org.uk>
Message-ID: <CAPybu_1==6gvwbWQWxSj_C3siGFTjvqNh1=Xj6jvu_xQFOA-Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark

On Tue, Jan 27, 2015 at 1:14 AM, Mark Brown <broonie@kernel.org> wrote:

>
> In general the best way to present a series is to start off with any bug
> fixes (so they can be sent to Linus and stable if needed), then move on
> to mechanical and stylistic cleanups (since they tend to be easy to
> review and apply) and finally move on to new functionality (since that
> is most likely to run into review problems and the cleanups should help
> review).

Will try to follow that pattern the next time.

The development of the patchset has been a bit chaotic. I opened up
the code to support more modes and then I realize that I could improve
the poor performance I was having with the driver....

>
>>   spi/xilinx: Support for spi mode LOOP
>>   spi/xilinx: Simplify data read from the Rx FIFO
>>   spi-xilinx: Simplify spi_fill_tx_fifo
>
> spi-xilinx?

Thanks! Fixed on the next version.

BTW what is preferred spi/xilinx: or spi: xilinx: ?I have seen both naming.

Thanks!


-- 
Ricardo Ribalda
