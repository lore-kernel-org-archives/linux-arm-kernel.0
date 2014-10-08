From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 8 Oct 2014 13:55:55 +0200
Subject: [PATCH v9 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <CAGm_ybj1DWituTMvG77+=8XY57skoLk+OwS_YLL0FXhrCOkohA@mail.gmail.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <CAGm_ybjP1WQfbyWR5GwQ6QnUjsy4qB_678+L=jgmMzz-rWkb0w@mail.gmail.com>
 <016401cfe2d3$23f3f0c0$6bdbd240$@kernel.org>
 <CAGm_ybiZQgok1oa3aar0ymgfu8KUn1j3LLqHiwQ81Mnh8zVHXQ@mail.gmail.com>
 <CABxcv=k==kP_+fc58a6ji_O572Cxzj_EmxmRo3kbc48k-qBO-w@mail.gmail.com>
 <CAGm_ybj1DWituTMvG77+=8XY57skoLk+OwS_YLL0FXhrCOkohA@mail.gmail.com>
Message-ID: <CABxcv=mMqyybEOTTrrC90hUKMR0iitqHUG2jJVX8o0MUJRb=CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vikas,

On Wed, Oct 8, 2014 at 1:51 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>>
>> Not related to your series but did you figure out why the
>> aclk200_disp1 and aclk300_disp1 clocks are left unused?
>>
>
> As mentioned earlier, I recently noticed that these clocks are
> preventing system from suspending.
> These clocks are used by the in-flight DRM display driver and once it
> is merged the display driver will be handling the clock during boot-up
> and suspend/resume.
>

Perfect, that was exactly what I was wondering. Thanks a lot for the
information!

Best regards,
Javier
