From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 16:28:46 +0100
Subject: [PATCH 11/16] ARM: ux500: Do not attempt to register non-existent
 i2c devices on Snowball
In-Reply-To: <201204171442.43954.arnd@arndb.de>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-12-git-send-email-lee.jones@linaro.org>
 <201204171442.43954.arnd@arndb.de>
Message-ID: <4F8D8C2E.1060105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/12 15:42, Arnd Bergmann wrote:
> On Tuesday 17 April 2012, Lee Jones wrote:
>> This patch prevents i2c devices which are not present on the Snowball
>> low-cost development board from being registered. Devices such as;
>> tc3589x, bu1780 and lp5521 are present on other supported boards,
>> but are not located on Snowball.
>>
>
> It looks like you only register the devices on mop500 now, but no longer
> on hrev60+, which before this patch registers a subset.

Quite right. I'll fix.


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
