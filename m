From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 27 Mar 2013 18:19:45 +0900
Subject: [PATCH] ARM: shmobile: r8a73a4: add thermal driver support
In-Reply-To: <20130327051703.GJ25431@verge.net.au>
References: <20130326013414.11796.9937.sendpatchset@w520>
 <87mwtqit29.wl%kuninori.morimoto.gx@renesas.com>
 <87li9ait0c.wl%kuninori.morimoto.gx@renesas.com>
 <20130327051703.GJ25431@verge.net.au>
Message-ID: <CANqRtoQVBR=53D47LQF_1XrSU4xmk9PyHRx3gzpfHAi2hSLvOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 2:17 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Mar 25, 2013 at 11:18:15PM -0700, Kuninori Morimoto wrote:
>> You can get current thermal by
>> > cat /sys/class/thermal/thermal_zone?/temp
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Thanks Morimoto-san.
>
> Magnus, if you are ok with this change could you either:
>
> * Let me know that your r8a73a4 is ready to be queued-up or;

The r8a73a4 SoC code is ready to be queued up! Please apply this patch
on top of that series. This code is also part of support for the
actual SoC, so keeping it together with the other SoC bits makes sense
at least to me!

Acked-by: Magnus Damm <damm@opensource.se>

Thanks for your help Morimoto-san and Simon.
