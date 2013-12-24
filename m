From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 24 Dec 2013 15:50:00 +0530
Subject: [PATCH v4 0/7] ARM: S3C24XX: Convert s3c2416 and s3c2443 to
 common clock framework
In-Reply-To: <1af701cf0048$b175b3c0$14611b40$@samsung.com>
References: <201312101614.29781.heiko@sntech.de>
 <201312231411.35417.heiko@sntech.de>
 <1af701cf0048$b175b3c0$14611b40$@samsung.com>
Message-ID: <CAK9yfHy6bEGB0eX7-+fKeB+Q9FxmT9ykmeiuucvWHN8EjOMMPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 24 December 2013 07:07, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Heiko St?bner wrote:
>>
>> Hi Kukjin,
>>
> Hi,
>
>> it seems you didn't have the time for this series during your 2nd round.
>>
>> I'm not sure what your plans/time constraint are, but according to the -
>> rc5
>> release mail from Linus [0], 3.13 will at least reach -rc8 so it seems as
>> if
>> there is still a bit of time to for 3.14 stuff.
>>
> Good news to us :-)
>
>> This series would really be a nice base for not only the other ccf-
>> conversions
>> (the already submitted s3c2410 and the s3c2412 which I'm currently working
>> on)
>> but also for broadening the dt-support, with the auxdata gone from the dt-
>> board file.
>>
> I agreed, let me try to send one more pull-request for 3.14 after finishing review of your patches.

While at it please also try to send the remaining pending patches.

-- 
With warm regards,
Sachin
