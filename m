From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 25 May 2015 18:03:15 +0300
Subject: [REGRESSION] No serial console output on BeagleBone Black
In-Reply-To: <CAMpxmJVhoWtyzhNBrnyYaiJSa_kSL_HQsJfbWQm5CQGTPac7=Q@mail.gmail.com>
References: <CAMpxmJVhoWtyzhNBrnyYaiJSa_kSL_HQsJfbWQm5CQGTPac7=Q@mail.gmail.com>
Message-ID: <556339B3.7060003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2015 05:24 PM, Bartosz Golaszewski wrote:
> Hi Tero,
>
> I tried booting a BeagleBone Black Rev C with current git, but got no
> output after u-boot's "Starting kernel ...". Bisect points at commit
> e3bc5358 ARM: dts: am33xx: add minimal l4 bus layout with control
> module support. Let me know if you need any more info.

Have you updated your DTB file recently? BBB seems to be booting nicely 
for me.

-Tero
