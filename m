From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 26 Aug 2016 17:52:05 +0200
Subject: [PATCH 0/3] ARM: dts: sun8i: Add dt nodes for sdio wifi
In-Reply-To: <1318301472223656@web13m.yandex.ru>
References: <20160826145236.30210-1-hdegoede@redhat.com>
 <1318301472223656@web13m.yandex.ru>
Message-ID: <43e78c53-77ee-5e20-a060-9e60ce37d3f0@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26-08-16 17:00, Icenowy Zheng wrote:
>
>
> 26.08.2016, 22:58, "Hans de Goede" <hdegoede@redhat.com>:
>> Hi Maxime,
>>
>> Now that Ulf has merged the post-power-on-delay-ms mmc-pwrseq patches
>> in his mmc/next tree and Rob Herring has accepted the esp8089 dt
>> bindings (and specifically the esp,crystal-26M-en property), these
>> are ready for merging.
>
> Can the driver now work without broken-cd?

Sort-off, my fork of the esp8089 driver has a workaround so that
it does not need broken-cd. I'm also working together with
Ulf (the mmc maintainer) to come up with a clean upstream
solution for this.

Regards,

Hans
