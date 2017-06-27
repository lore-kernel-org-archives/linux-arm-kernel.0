From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 27 Jun 2017 15:42:53 -0700
Subject: [PATCH] usb: gadget: udc-xilinx: remove useless variable
 assignment in xudc_read_fifo()
In-Reply-To: <20170627213030.GA5574@embeddedgus>
References: <20170627213030.GA5574@embeddedgus>
Message-ID: <20170627224253.ykvkfpvoqyniklnj@xsjsorenbubuntu.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-06-27 at 16:30:30 -0500, Gustavo A. R. Silva wrote:
> Value assigned to variable bufferspace at line 637 is overwritten
> at line 613, before it can be used. This makes such variable
> assignment useless.
> 
> Addresses-Coverity-ID: 1397677
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
