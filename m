From: Josh.wu@atmel.com (Wu, Josh)
Date: Thu, 12 May 2011 17:26:59 +0800
Subject: [PATCH] [media] at91: add Atmel Image Sensor Interface
	(ISI)support
In-Reply-To: <20110512074725.GA1356@n2100.arm.linux.org.uk>
References: <1305186138-5656-1-git-send-email-josh.wu@atmel.com>
	<20110512074725.GA1356@n2100.arm.linux.org.uk>
Message-ID: <4C79549CB6F772498162A641D92D532801AC28CD@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell

From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] Sent: Thursday, May 12, 2011 3:47 PM
> On Thu, May 12, 2011 at 03:42:18PM +0800, Josh Wu wrote:
>> +err_alloc_isi:
>> +	clk_disable(pclk);
> clk_put() ?
Ok, will be fixed in V2 patch. Thanks.

Best Regards,
Josh Wu
