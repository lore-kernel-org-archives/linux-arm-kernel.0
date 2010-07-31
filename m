From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 31 Jul 2010 17:38:06 +0200
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com> (Marek
	Vasut's message of "Sat\, 31 Jul 2010 06\:22\:27 +0200")
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <87k4ob1x29.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> The wakealarm capability was incorrectly set after the RTC was registered, which
> resulted into the sysfs node not being created.

On my platform, without this patch:
> cat /sys/devices/platform/pxa-rtc/power/wakeup
> enabled

The sysfs node is created. What's the issue you're having ?

Cheers.

--
Robert
