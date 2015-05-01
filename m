From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 01 May 2015 18:17:45 +0200
Subject: [PATCH v2 1/4] ARM: pxa: add memory resource to RTC device
In-Reply-To: <1430426233-7461-2-git-send-email-robh@kernel.org> (Rob Herring's
 message of "Thu, 30 Apr 2015 15:37:10 -0500")
References: <1430426233-7461-1-git-send-email-robh@kernel.org>
 <1430426233-7461-2-git-send-email-robh@kernel.org>
Message-ID: <87ioccjmqe.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> Add the memory resource for the sa1100-rtc device. Since the memory
> resource is already present in the pxa_rtc_resources, that makes
> sa1100_rtc_resources and pxa_rtc_resources equivalent, so use
> pxa_rtc_resources for both devices and remove the duplicate
> sa1100_rtc_resources.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> v2:
> - Rebase to v4.1-rc1
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
