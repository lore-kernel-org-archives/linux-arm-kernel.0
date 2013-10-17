From: timur@tabi.org (Timur Tabi)
Date: Thu, 17 Oct 2013 08:22:19 -0500
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <525FD65B.3040004@metafoo.de>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <525FD4C7.3050806@tabi.org> <525FD65B.3040004@metafoo.de>
Message-ID: <525FE48B.7020709@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lars-Peter Clausen wrote:
>>> >>+    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> >>+    sai->base = devm_ioremap_resource(&pdev->dev, res);
>> >
>> >Why not use of_iomap()?
> Because it won't check for conflicting resource regions.

Maybe I've been out of the loop for too long, but why is that a 
particular problem with this driver?
