From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 17:29:05 +0200
Subject: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
In-Reply-To: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <353732273.2TKdyNJ83M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 23:05:59 Hanjun Guo wrote:
> This patch set is example of the sort of driver changes needed to boot
> Juno using ACPI tables, which using the ACPI tables devloped for MS
> Windows and published by ARM [1].

What about platform support?

I see that there is a patch in your git tree at
https://git.linaro.org/leg/acpi/acpi.git/commitdiff/b9a635e3b4cb167d399
that exposes the raw system registers in the same way that the DT support
does, which I guess is not how you plan to do it for ACPI when you are
done.

Is that still work in progress? How do you plan to abstract things
like the hwmon, LEDs, GPIO etc that are handled through the
sysregs in hardware?

	Arnd
