From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 28 Jan 2012 08:01:10 +0100
Subject: [PATCH 1/3] ARM: at91/tclib: take iomem size from resource
In-Reply-To: <a311afe3c46da62f7a1e82d2fa933e24ad4eef7e.1326995849.git.nicolas.ferre@atmel.com>
References: <1326996312-9244-1-git-send-email-nicolas.ferre@atmel.com>
 <a311afe3c46da62f7a1e82d2fa933e24ad4eef7e.1326995849.git.nicolas.ferre@atmel.com>
Message-ID: <20120128070110.GB705@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:05 Thu 19 Jan     , Nicolas Ferre wrote:
> Requesting iomem region and ioremaping is now done using
> the resource size specified instead of a constant value.
> 
> Each <SoC>_device.c file is modified accordingly to reflect
> actual user interface size.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
this is a fix shoud go for 3.3

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
