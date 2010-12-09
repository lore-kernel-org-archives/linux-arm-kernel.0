From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Thu, 9 Dec 2010 15:35:05 +0100
Subject: [PATCH 01/20] mfd/ab8500: remove spi support
In-Reply-To: <20101209142912.GM8884@sortiz-mobl>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
	<1291388753-14662-2-git-send-email-sundar.iyer@stericsson.com>
	<20101209142912.GM8884@sortiz-mobl>
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B18047C7D405F@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sam,

[pruning up the CC list]

>-----Original Message-----
>From: Samuel Ortiz [mailto:sameo at linux.intel.com]
>
>> Since the Ab8500 v1.0, the SPI support is deprecated on the HW.
>I'm fine with that, but you really don't want to be able to support pre 1.0
>devices ?

AFAIK, there aren't active pieces of those outside STE :) and it is accepted
that we drop the support for them.

Cheers!
