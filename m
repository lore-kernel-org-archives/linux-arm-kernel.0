From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue, 12 Jul 2011 10:04:39 -0700
Subject: [PATCH 1/1] ARM: i.MX50/53: debug-macro: fix UART_PADDR
In-Reply-To: <20110712133231.GQ6069@pengutronix.de>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
	<20110712133231.GQ6069@pengutronix.de>
Message-ID: <4E1C7EA7.7060800@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/12/2011 6:32 AM, Sascha Hauer wrote:
> Troy,
> 
> On Sat, Jul 09, 2011 at 03:51:53PM -0700, Troy Kisky wrote:
>> The i.MX51 UART_PADDR value does not work for MX50/53.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> Please rebase the patch on my for-next branch and use CONFIG_SOC_IMX*
> instead of CONFIG_ARCH_*.
> 
> Sascha
> 
>> ---
