From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 25 May 2015 18:28:10 +0200
Subject: [REGRESSION] No serial console output on BeagleBone Black
In-Reply-To: <556339B3.7060003@ti.com>
References: <CAMpxmJVhoWtyzhNBrnyYaiJSa_kSL_HQsJfbWQm5CQGTPac7=Q@mail.gmail.com>
 <556339B3.7060003@ti.com>
Message-ID: <CAMpxmJV_eL0dkiErMDpn3AHaEFDh04DhBtf7HBnEwPG80paODQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-25 17:03 GMT+02:00 Tero Kristo <t-kristo@ti.com>:
> On 05/25/2015 05:24 PM, Bartosz Golaszewski wrote:
>>
>> Hi Tero,
>>
>> I tried booting a BeagleBone Black Rev C with current git, but got no
>> output after u-boot's "Starting kernel ...". Bisect points at commit
>> e3bc5358 ARM: dts: am33xx: add minimal l4 bus layout with control
>> module support. Let me know if you need any more info.
>
>
> Have you updated your DTB file recently? BBB seems to be booting nicely for
> me.

Sorry for the noise - I double-checked everything from scratch and it
was apparently the zImage that wasn't getting updated properly. It
boots fine now.

Thanks,
Bartosz Golaszewski
