From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sun, 27 Mar 2016 22:57:23 +0900
Subject: [PATCH v5 00/21] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
In-Reply-To: <CANAwSgTihXTNasXaSE-L2oZcwCcovUiat_yv=Opweo3zvMjZDg@mail.gmail.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
 <56F36D65.6030504@samsung.com>
 <CANAwSgTihXTNasXaSE-L2oZcwCcovUiat_yv=Opweo3zvMjZDg@mail.gmail.com>
Message-ID: <CAGTfZH3UYY1o6z=i5ADe0jNih6y6rkYT09Q==V2Yv+hA4Yx+ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anand,

On Sun, Mar 27, 2016 at 9:28 PM, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Chanwoo Choi,
>
> On 24 March 2016 at 10:00, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> Dear Anand and Tobias,
>>
>> To Anand,
>> First of all, thanks to your test on previous patchset.
>> I removed the your tested-by tag from this version
>> because I modified the devfreq core using DEVFREQ_TRANSITION_NOTIFIER notifier.
>> I think that this patch-set need to test with this patchset.
>> If you possible, could you please test this patch-set? Thanks in advance.
>>
> I have being following this series, I have tested this series on Odroid U3.
>
> Please feel free to add my Tested tag if needed
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks for your test again.

Best Regards,
Chanwoo Choi

[snip]
