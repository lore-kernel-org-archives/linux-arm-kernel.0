From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 9 Dec 2010 16:36:35 +0100
Subject: [PATCH 01/20] mfd/ab8500: remove spi support
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B18047C7D405F@EXDCVYMBSTM006.EQ1STM.local>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
	<1291388753-14662-2-git-send-email-sundar.iyer@stericsson.com>
	<20101209142912.GM8884@sortiz-mobl>
	<33A307AF30D7BF4F811B1568FE7A9B18047C7D405F@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <20101209153634.GQ8884@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sundar,

On Thu, Dec 09, 2010 at 03:35:05PM +0100, Sundar R IYER wrote:
> Hi Sam,
> 
> [pruning up the CC list]
> 
> >-----Original Message-----
> >From: Samuel Ortiz [mailto:sameo at linux.intel.com]
> >
> >> Since the Ab8500 v1.0, the SPI support is deprecated on the HW.
> >I'm fine with that, but you really don't want to be able to support pre 1.0
> >devices ?
> 
> AFAIK, there aren't active pieces of those outside STE :) 
Ok, that's a good reason. Please add my:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
