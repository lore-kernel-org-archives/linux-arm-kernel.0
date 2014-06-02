From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Jun 2014 11:07:19 +0200
Subject: [PATCH v2] i2c: nuc900: remove driver
In-Reply-To: <1401654925-20791-1-git-send-email-wsa@the-dreams.de>
References: <1401654925-20791-1-git-send-email-wsa@the-dreams.de>
Message-ID: <5344745.s7ruhXG564@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 01 June 2014 22:35:25 Wolfram Sang wrote:
> Arnd said in another patch:
> 
> "As far as I can tell, this driver must have produced this
> error for as long as it has been merged into the mainline kernel, but
> it was never part of the normal build tests:
> 
> drivers/i2c/busses/i2c-nuc900.c: In function 'nuc900_i2c_probe':
> drivers/i2c/busses/i2c-nuc900.c:601:17: error: request for member
> 'apbfreq' in something not a structure or union
>   ret = (i2c->clk.apbfreq)/(pdata->bus_freq * 5) - 1;
>                  ^
> This is an attempt to get the driver to build and possibly
> work correctly, although I do wonder whether we should just
> remove it, as it has clearly never worked."
> 
> I agree with removing it since nobody showed interest in Arnd's fixup
> patch.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Wan ZongShun <mcuos.com@gmail.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
