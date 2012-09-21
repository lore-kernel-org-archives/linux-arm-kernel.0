From: davem@davemloft.net (David Miller)
Date: Thu, 20 Sep 2012 22:22:21 -0400 (EDT)
Subject: [PATCH] at91ether: return PTR_ERR if call to clk_get fails
In-Reply-To: <505AC8D6.5080404@atmel.com>
References: <1348124676-6627-1-git-send-email-devendra.aaru@gmail.com>
 <505AC8D6.5080404@atmel.com>
Message-ID: <20120920.222221.1362666243095294465.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 20 Sep 2012 09:42:14 +0200

> On 09/20/2012 09:04 AM, Devendra Naga :
>> we are currently returning ENODEV, as the clk_get may give a exact
>> error code in its returned pointer, assign it to the ret by using the
>> PTR_ERR function, so that the subsequent goto label will jump to the
>> error path and clean the driver and return the error correctly.
>> 
>> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied, thanks.
