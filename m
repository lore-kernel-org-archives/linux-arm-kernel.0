From: b38343@freescale.com (Robin Gong)
Date: Fri, 17 Oct 2014 11:37:45 +0800
Subject: iMX6 sdma firmware error "imx/sdma/sdma-imx6q.bin"
In-Reply-To: <1412100979.21234.YahooMailNeo@web161404.mail.bf1.yahoo.com>
References: <1412100979.21234.YahooMailNeo@web161404.mail.bf1.yahoo.com>
Message-ID: <20141017033731.GA5283@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 11:16:19AM -0700, Anand Moon wrote:
> Hi All,
> 
> I am trying to build the firmware image by using the following patch.
> 
> https://lkml.org/lkml/2013/1/8/15
> 
> 
> But I see following error. Could some body help me with error.
> 
> [    7.247076] cma: cma_alloc(): returned eb548820
> [    7.247663] __allocate_fw_buf: fw-imx/sdma/sdma-imx6q.bin buf=e856f400
> [    7.248932] imx-sdma 20ec000.sdma: Direct firmware load for imx/sdma/sdma-imx6q.bin failed with error -2
> [    7.248961] __fw_free_buf: fw-imx/sdma/sdma-imx6q.bin buf=e856f400 data=  (null) size=0
> [    7.249068] imx-sdma 20ec000.sdma: firmware not found
> [    7.249381] device: 'dma1chan0': device_add
> 
> Actually kernel build will create a file /lib/firmware/imx/sdma/sdma-imx6q-to1.bin
> 
> so I rename the file to /lib/firmware/imx/sdma/sdma-imx6q.bin
wrong path?firware/imx/sdma/sdma-imx6q.bin.
> 
> But I am still receiving the same error.
> 
> -Anand Moon
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
