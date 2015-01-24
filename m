From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Jan 2015 13:54:28 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable CONFIG_FHANDLE
In-Reply-To: <54C20CD5.7060001@collabora.co.uk>
References: <1417176414-21558-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <54786C1D.3050306@collabora.co.uk> <54BC9995.4020300@samsung.com>
 <54C20CD5.7060001@collabora.co.uk>
Message-ID: <54C32584.4040601@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/15 17:56, Javier Martinez Canillas wrote:
> Hello Kukjin,
> 
Hi,

> On 01/19/2015 06:43 AM, Joonyoung Shim wrote:
>>>
>>
>> I also hope merge this, already multi_v7_defconfig supports this.
>>
> 
> I would also hope this to be merged since it's required to boot
> using systemd.
> 
>> Thanks.
>>
>>> This is certainly required for newer systemd and has to be enabled.
>>>
>>> But it would also be great to have enabled all the config symbols
>>> that are listed as requirements in the systemd README file:
>>>
>>> http://cgit.freedesktop.org/systemd/systemd/tree/README.
>>>
>>> Tony added that support to OMAP2+ defconfig in commit 673ce00c
>>> ("ARM: omap2plus_defconfig: Add support for distros with systemd")
>>> so the same should be done in exynos_defconfig.
>>>
>>> That can of course be a follow-up patch though, so for $subject:
>>>
>>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>
Thanks, applied.

- Kukjin
