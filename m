From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 May 2012 12:54:12 +0800
Subject: [PATCH 05/15] ARM: ux500: New DT:ed snowball_platform_devs for
 one-by-one device enablement
In-Reply-To: <CACRpkdZoaoGYqgikd4RqhFToPzkEWb7fx8cmOTrrZcxeQOkROQ@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-6-git-send-email-lee.jones@linaro.org>
 <4F967B01.2050807@linaro.org>
 <CACRpkdZoaoGYqgikd4RqhFToPzkEWb7fx8cmOTrrZcxeQOkROQ@mail.gmail.com>
Message-ID: <4FC304F4.9020902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Linus, Can you please take 05 and 06 please, as some of the other patches
>> depend on them. Thanks.
>
> I think I've done that now and I'm planning a first pull request to ARM SoC
> to get the base into -next ASAP.

Looks like neither of these made it into Mainline, however subsequent 
patches which made changes to them did. This has caused some merge 
error, thus the code, especially in arch/arm/mach-ux500/cpu-db8500.c, 
but also in arch/arm/mach-ux500/board-mop500.c is quite wrong. :(

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
