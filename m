From: Josh.wu@atmel.com (Wu, Josh)
Date: Thu, 12 May 2011 17:56:39 +0800
Subject: [PATCH] [media] at91: add Atmel Image Sensor Interface
	(ISI)support
In-Reply-To: <Pine.LNX.4.64.1105121131040.24486@axis700.grange>
References: <1305186138-5656-1-git-send-email-josh.wu@atmel.com>
	<20110512074725.GA1356@n2100.arm.linux.org.uk>
	<4C79549CB6F772498162A641D92D532801AC28CD@penmb01.corp.atmel.com>
	<Pine.LNX.4.64.1105121131040.24486@axis700.grange>
Message-ID: <4C79549CB6F772498162A641D92D532801AC291A@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski [mailto:g.liakhovetski at gmx.de] Sent: Thursday, May 12, 2011 5:32 PM

> On Thu, 12 May 2011, Wu, Josh wrote:
>> Hi, Russell
>> 
>> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] Sent: Thursday, May 12, 2011 3:47 PM
>> > On Thu, May 12, 2011 at 03:42:18PM +0800, Josh Wu wrote:
>> >> +err_alloc_isi:
>> >> +	clk_disable(pclk);
>> > clk_put() ?
>> Ok, will be fixed in V2 patch. Thanks.

> You might wait with v2 until I find time to review your patch. Will take a 
> couple of days, I think. A general question, though: how compatible is 
> this driver with the AVR32?
That is ok. 
For AVR32, I think I need time to check with AVR team. I will update the status when I got more information.

Best Regards,
Josh Wu
