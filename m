From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 1 May 2014 15:09:29 +0530
Subject: [PATCH v3 6/6] arm: exynos: Add /dev/bL_status user interface on
 Exynos5420
In-Reply-To: <alpine.LFD.2.11.1404301044280.980@knanqh.ubzr>
References: <1398528348-21214-1-git-send-email-a.kesavan@samsung.com>
 <1398528348-21214-7-git-send-email-a.kesavan@samsung.com>
 <535E3A8C.6070304@linaro.org>
 <CAM4voak-oXToBK=owO=jmpwk3rDkg71JS=8YOTz1HfiQvZa5Vw@mail.gmail.com>
 <alpine.LFD.2.11.1404301044280.980@knanqh.ubzr>
Message-ID: <CAM4voaktFuB4fH08QE32q=zH9p=yeNeXmf9qeTDGfZeQqu0K-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Apr 30, 2014 at 8:19 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 28 Apr 2014, Abhilash Kesavan wrote:
>
>> On Mon, Apr 28, 2014 at 4:55 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>> > On 04/26/2014 06:05 PM, Abhilash Kesavan wrote:
>> >>
>> >> Add a user interface to check the core and cluster status on
>> >> Exynos5420. This can be utilized while debugging mcpm issues.
>> >> cat /dev/bL_status will show the current power status of all
>> >> the 8 cores along with the cluster.
>> >>
>> >> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> >> Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
>> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> >> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> >> ---
>> >
>> >
>> > Hi Abhilash,
>>
>> Hi Daniel,
>> >
>> > I don't think you should add this file.
>> >
>> > 1. big Little is not exynos specific
>> But the core control/status bits that I am accessing are exynos
>> specific and currently it is being enabled only on 5420.
>
> Maybe yt is not worth pushing this patch upstream?  Once basic debugging
> is over, you shouldn't have to use this code anymore.
OK, will drop this patch.

Regards,
Abhilash
>
>
> Nicolas
