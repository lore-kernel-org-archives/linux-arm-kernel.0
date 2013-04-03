From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 03 Apr 2013 17:27:00 +0400
Subject: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
In-Reply-To: <87sj38cvfn.wl%kuninori.morimoto.gx@renesas.com>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
 <87y5d16b1d.wl%kuninori.morimoto.gx@renesas.com>
 <515AC4C8.1080803@cogentembedded.com>
 <87sj38cvfn.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <515C2E24.1080108@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03-04-2013 4:25, Kuninori Morimoto wrote:

>>> Current ARM SoC is trying to not use platform_device_register()
>>> Please use platform_device_register_xxx()
>>> Same comment for [2/2]

>>      Is there some rationale to it? I don't find platform_device_register_xxx()
>> especially handy to use.

> http://www.spinics.net/lists/linux-sh/msg16871.html

    I don't see there actual Greg KH's rationale for not using 
platform_register_device().

WBR, Sergei
