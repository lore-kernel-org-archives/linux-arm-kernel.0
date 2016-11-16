From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 Nov 2016 14:48:47 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: add missing options for
 systemd
In-Reply-To: <7hshqt6fyo.fsf@baylibre.com>
References: <20161114160146.20679-1-nsekhar@ti.com>
 <7hshqt6fyo.fsf@baylibre.com>
Message-ID: <2bdfcd2f-12db-6cb3-fb60-ffbf5b535f28@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 November 2016 12:34 AM, Kevin Hilman wrote:
> Sekhar Nori <nsekhar@ti.com> writes:
> 
>> Some kernel configuration options required for systemd
>> support are missing in davinci_all_defconfig. Add them.
>>
>> This is based on recommendations in:
>>
>>     http://cgit.freedesktop.org/systemd/systemd/tree/README
>>
>> Options which kernel enables by default (and will thus be removed
>> upon next savedefconfig update) are not included.
>>
>> Tested on OMAP-L138 LCDK board with fully up to date armv5
>> archlinux filesystem.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>

Applied to v4.10/defconfig

Thanks,
Sekhar
