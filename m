From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Jan 2013 21:32:13 +0530
Subject: [PATCH V2] ARM: davinci: da850: add RTC DT entries
In-Reply-To: <1359359268-9781-1-git-send-email-mrugesh.mk@ti.com>
References: <1359359268-9781-1-git-send-email-mrugesh.mk@ti.com>
Message-ID: <5106A105.6030004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mrugesh,

On 1/28/2013 1:17 PM, Mrugesh Katepallewar wrote:
> Add RTC DT entries in da850 dts file.
> 
> Signed-off-by: Mrugesh Katepallewar <mrugesh.mk@ti.com>
> ---
> Applies on top of v3.8-rc4 of linus tree.
> 
> This patch is depending on 
> "ARM: davinci: da850: add interrupt-parent property in soc node"
> https://patchwork.kernel.org/patch/2044101/

> Tested on da850-evm device.
> 
> Test Procedure:
> date 2013.01.28-10:00:00 (usage: date[YYYY.]MM.DD-hh:mm[:ss])
> hwclock -w
> reset board and check system time.

Queuing this for v3.9. The testing information above is useful and
should be part of the changelog. I moved it there while committing.

It will be nice to check the alarm functionality as well. Can you check
that and let me know that works as well?

Thanks,
Sekhar
