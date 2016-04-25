From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 25 Apr 2016 18:19:39 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: enable CONFIG_FHANDLE
In-Reply-To: <7hh9eycz73.fsf@baylibre.com>
References: <1460023562-7907-1-git-send-email-nsekhar@ti.com>
 <7h37qvn4v5.fsf@baylibre.com> <570B7C89.9030200@ti.com>
 <5710B87A.7060201@ti.com> <7hh9eycz73.fsf@baylibre.com>
Message-ID: <571E1263.8050906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 April 2016 04:16 AM, Kevin Hilman wrote:
> Sekhar Nori <nsekhar@ti.com> writes:

>> From: Sekhar Nori <nsekhar@ti.com>
>> Date: Fri, 15 Apr 2016 14:19:26 +0530
>> Subject: [PATCH] ARM: davinci_all_defconfig: support systemd
>>
>> CONFIG_FHANDLE is required by systemd[1], which is the
>> default init system in more and more distributions.
>> So lets enable it for DaVinci platforms as well.
>>
>> While at it, remove stale entry CONFIG_INOTIFY=y
>>
>> [1] https://github.com/systemd/systemd/blob/master/README#L37
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>

Applied.

Thanks,
Sekhar
