From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 26 Jul 2016 10:27:09 -0400
Subject: [STLinux Kernel] [PATCH 1/1] drm/sti: use new Reset API
In-Reply-To: <20160725104015.GK14925@dell>
References: <20160725100933.9261-1-lee.jones@linaro.org>
 <20160725103232.GA4278@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160725104015.GK14925@dell>
Message-ID: <CAOw6vbLCQG6CJ2adntdSDsV2djmOKv0hS3Ks6niNEanXOR1u9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 6:40 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 25 Jul 2016, Peter Griffin wrote:
>> On Mon, 25 Jul 2016, Lee Jones wrote:
>>
>> > Since 0b52297f228 ("reset: Add support for shared reset controls") the
>> > new Reset API now demands consumers choose either an *_exclusive or a
>> > *_shared line when requesting reset lines.
>> >
>> > This issue was found when running a kernel containing the aforementioned
>> > patch  which includes an informitive WARN().  It implies that one or
>> > more used reset lines are in fact shared.  This is why we're using the
>> > *_shared variant.
>> >
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > ---
>> >  drivers/gpu/drm/sti/sti_compositor.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Your missing a changelog on the v2 version.
>
> This isn't really a v2, hence the lack if [PATCH vX] increment.
>
> This is v1 with a more verbose changelog.
>
>> Apart from that:
>>  Acked-by: Peter Griffin <peter.griffin@linaro.org>
>
> Ta.

Applied to drm-misc, thanks for revising.

>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
