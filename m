From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 13 Jul 2015 20:10:21 +0900
Subject: [PATCH 4/6] ARM: dts: Exynos4210: add CPU OPP and regulator
 supply property
In-Reply-To: <4721448.dpAUKITTdt@amdc1976>
References: <'@samsung.com> <55889E59.1070001@samsung.com>
 <5588A748.2070407@samsung.com> <4721448.dpAUKITTdt@amdc1976>
Message-ID: <CAJKOXPcX83C+=D-Fpstgu8N1y7-TFM3tXki_YfUyKkU1q3EfSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-13 20:02 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
>
> Hi,
>
> On Tuesday, June 23, 2015 09:24:40 AM Krzysztof Kozlowski wrote:
>> On 23.06.2015 08:46, Krzysztof Kozlowski wrote:
>> > On 23.06.2015 00:04, Michael Turquette wrote:
>> >> Quoting Kukjin Kim (2015-06-21 18:46:26)
>> >>> Krzysztof Kozlowski wrote:
>> >>>>
>> >>>> On 22.06.2015 10:38, Kukjin Kim wrote:
>> >>>>> Krzysztof Kozlowski wrote:
>> >>>>>> 2015-05-08 9:18 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>> >>>>>>> 2015-04-04 1:43 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
>> >>>>>>>> From: Thomas Abraham <thomas.ab@samsung.com>
>> >>>>>>>>
>> >>>>>>>> For Exynos4210 platforms, add CPU operating points and CPU
>> >>>>>>>> regulator supply properties for migrating from Exynos specific
>> >>>>>>>> cpufreq driver to using generic cpufreq driver.
>> >>>>>>>>
>> >>>>>>>> Changes by Bartlomiej:
>> >>>>>>>> - removed Exynos5250 and Exynos5420 support for now
>> >>>>>>>>
>> >>>>>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> >>>>>>>> Cc: Doug Anderson <dianders@chromium.org>
>> >>>>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> >>>>>>>> Cc: Andreas Faerber <afaerber@suse.de>
>> >>>>>>>> Cc: Sachin Kamat <sachin.kamat@linaro.org>
>> >>>>>>>> Cc: Andreas Farber <afaerber@suse.de>
>> >>>>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> >>>>>>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> >>>>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> >>>>>>>
>> >>>>>>> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> >>>>>>
>> >>>>>> Rebased and applied to my tree, I'll sent it later to Kukjin unless he
>> >>>>>> picks it by himself from LKML.
>> >>>>>>
>> >>>>> Hi, as far as I know, this is for v4.2 not v4.1 so it will be applied based on
>> >>>>> v4.2-rc1 after v4.2-rc1 release.
>> >>>>
>> >>>> You mean it is for v4.3, not v4.2?
>> >>>>
>> >>> Oops, yes v4.3.
>> >>>
>> >>> Thanks for the correction.
>> >>
>> >> Kukjin & Krzysztof,
>> >>
>> >> I'm confused on this point. I was planning to take patches 1, 2, 3, 5
>> >> and 6 towards 4.2 (e.g. in the pull request that I'll send out this
>> >> week).
>> >>
>> >> Is patch 4 going out for 4.2 or 4.3?
>> >
>> > It is quite late for sending pull request to arm-soc for 4.2.
>> > For example SoCFPGA pull request from last week was rejected:
>> > http://comments.gmane.org/gmane.linux.ports.arm.kernel/417980
>>
>> Oh, that was wrong link. Here it is:
>> http://www.spinics.net/lists/arm-kernel/msg425911.html
>>
>> > If you want to take it for 4.2 then I am fine with it but this will
>> > cause some easy but annoying conflicts. There aren't difficult - just
>> > most of nodes in board DTS changed their place.
>> >
>> > Example of resolution (target file after merge, with cpu nodes reordered
>> > alphabetically):
>> > https://github.com/krzk/linux/commit/2cec3cb48abaf44848c62f1c0836b772eb4680dd
>
> This patch is needed for v4.2 as other changes has been already
> merged.
>
> Krzysztof/Kukjin, could you please take care of it?

Of course! It is already in my queue. I'll send it later to Kukjin for
4.3 (unless he picks it also).

BTW for other patchsets you still need acks from Samsung clock
maintainers. Did you poke Sylwester or Tomasz about it?

Best regards,
Krzysztof
