From: gnurou@gmail.com (Alexandre Courbot)
Date: Thu, 12 Nov 2015 21:53:50 +0900
Subject: [PATCH v2] nouveau: arm: Add MODULE_FIRMWARE for gk20a
In-Reply-To: <CABr+WTmG1p6-dGGpWJgGBAJydyWz=2aPj-e93X9metn8y8Qrcg@mail.gmail.com>
References: <1443452893-18246-1-git-send-email-kwizart@gmail.com>
 <CAAVeFuJLJO4LvLqq2w9gMe6V6L3VDi+Gz59GvwKF2v8OWTWgBQ@mail.gmail.com>
 <CABr+WTmG1p6-dGGpWJgGBAJydyWz=2aPj-e93X9metn8y8Qrcg@mail.gmail.com>
Message-ID: <CAAVeFuLNadYawJB0zZHzMc3CA7GiukEox=FGH8wupXjyK576MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 6:29 PM, Nicolas Chauvet <kwizart@gmail.com> wrote:
> 2015-09-30 6:57 GMT+02:00 Alexandre Courbot <gnurou@gmail.com>:
>>
>> On Tue, Sep 29, 2015 at 12:08 AM, Nicolas Chauvet <kwizart@gmail.com>
>> wrote:
>> > This patch is needed by initramfs tools to detect
>> > the required firmware files for the module.
>> >
>> > This patch tests for either TEGRA_124_SOC or TEGRA_132_SOC
>> > for the firmwares related to the Tegra K1 generation.
>> >
>> > v2: move the MODULE_FIRMWARE to the nvidia_platform.c file.
>> >  This will avoid to test for NOUVEAU_PLATFORM_DRIVER
>>
>> Nice, thanks for doing this change!
>>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
>
> Thx for the review.
> FYI I've tested the patch on top of 4.3+ kernels, and the initramfs
> generated with dracut works as expected.
>
> Is there any other concern with this patch ?
>
> It's certainly late for 4.4,I would expect it to hit kernel 4.3 at some
> point, but I don't think everything is wired from userspace(Xorg/Wayland)
> wrt dGPU support.
> So It could also wait for 4.5.
> What do you think ?

I don't see a particular reason to hurry, however this patch has been
sitting around for one month now - Ben, is there any particular reason
for not merging it?
