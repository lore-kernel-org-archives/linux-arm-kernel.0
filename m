From: Josh.wu@atmel.com (Wu, Josh)
Date: Fri, 3 Jun 2011 16:57:03 +0800
Subject: [PATCH v2] [media] at91: add Atmel Image Sensor Interface (ISI)
	support
In-Reply-To: <201105271549.46099.arnd@arndb.de>
References: <1306496329-14535-1-git-send-email-josh.wu@atmel.com>
	<201105271549.46099.arnd@arndb.de>
Message-ID: <4C79549CB6F772498162A641D92D532801DAC9AD@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd

On Friday, May 27, 2011 9:50 PM, Arnd Bergmann wrote

>On Friday 27 May 2011, Josh Wu wrote:
>> This patch is to enable Atmel Image Sensor Interface (ISI) driver support.
>> - Using soc-camera framework with videobuf2 dma-contig allocator
>> - Supporting video streaming of YUV packed format
>> - Tested on AT91SAM9M10G45-EK with OV2640
>> 
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>

> Looks good to me now.

> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thank you very much. I'll send a version 3 code.

Best Regards,
Josh Wu
