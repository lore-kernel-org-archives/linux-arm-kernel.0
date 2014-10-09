From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 10 Oct 2014 00:10:38 +0200
Subject: [PATCH v9 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <7hbnpknc98.fsf@deeprootsystems.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <7hiojuno9e.fsf@deeprootsystems.com>
 <CAM4voanoOV44EQveAeikp1P0bXCU8HHdX2XDi3jwLkfQOP0CNQ@mail.gmail.com>
 <CABxcv==V0vR2XXq5cKzbaqkCbtkqKgrhJotdPSM5K0uyNW968w@mail.gmail.com>
 <7hbnpknc98.fsf@deeprootsystems.com>
Message-ID: <CABxcv=mzU+csPinPcd4JANtHe1ASWzf0J+k5NzxDDukZe_UQKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On Thu, Oct 9, 2014 at 11:50 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>
>> On Peach boards, the S3C source clock is the max77802 32kHZ AP clock
>> so I fixed that with commit 8bd43b6 ("ARM: dts: Add rtc_src clk for
>> s3c-rtc on exynos Peach boards") but didn't send a patch to enable the
>> max77802 subdevices on exynos_defconfig.
>>
>> I'll post a patch to enable those config options today and maybe they
>> can be considered as -rc material.
>
> Great, thanks.
>

Now I remember why I didn't enable those options at the time and it
was because Vivek Gautam already did. Now, I see that the max77802
config options were removed on a later patch, probably by mistake.

So I posted a patch [0] to re-enable those options but it seems I
forgot to cc you, sorry about that.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/10/9/413
