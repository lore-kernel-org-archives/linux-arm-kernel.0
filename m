From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 25 Nov 2012 13:21:52 +0100
Subject: [PATCH] ARM: pxa: pxa27x.c: add dummy SA1100 rtc clock
In-Reply-To: <1353712328-15830-1-git-send-email-andrea.adami@gmail.com>
 (Andrea Adami's message of "Sat, 24 Nov 2012 00:12:08 +0100")
References: <1353712328-15830-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <87ehjh3man.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrea Adami <andrea.adami@gmail.com> writes:
> * Using pxa27x you could now build both RTC_DRV_PXA and RTC_DRV_SA1100.
> * Make sure you don't use both together: link /dev/rtc0 or /dev/rtc1
> * to /dev/rtc according to your requirement.
Weird to have stars at the beginning of each line in the patch description.
But anyway :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
