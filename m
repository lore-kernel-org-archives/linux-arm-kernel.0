From: timur@tabi.org (Timur Tabi)
Date: Thu, 17 Oct 2013 08:37:25 -0500
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <525FE728.90403@metafoo.de>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <525FD4C7.3050806@tabi.org> <525FD65B.3040004@metafoo.de>
 <525FE48B.7020709@tabi.org> <525FE728.90403@metafoo.de>
Message-ID: <525FE815.1040300@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lars-Peter Clausen wrote:
>> >Maybe I've been out of the loop for too long, but why is that a particular
>> >problem with this driver?

> It is usually something you'd want to check in general to make sure that you
> don't have multiple device that access the same iomem region at the same time.

I understand that, but I'm trying to figure out why of_iomap() is okay 
for hundreds of other drivers, but not this one.  I've used it dozens of 
times myself, without ever worrying about overlapping regions.
