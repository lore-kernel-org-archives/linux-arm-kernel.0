From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 28 Mar 2012 15:36:07 +0800
Subject: [GIT PULL][for 3.4] pull request from arch-pxa git for board
 branch
In-Reply-To: <CAOesGMjD9QYCrE5wVxSghPHMoO+CuMd_CNhQUVyDS=Guyjr6YQ@mail.gmail.com>
References: <CAN1soZyCRQSVUQe+iBWX0nGwViWjp=W32BkYCcUUDmR894PJ9w@mail.gmail.com>
 <CAOesGMjD9QYCrE5wVxSghPHMoO+CuMd_CNhQUVyDS=Guyjr6YQ@mail.gmail.com>
Message-ID: <CAN1soZymgHW4bsgcwS655Zu-vcHQWpDtVFaaBsXdTifQ5QhjuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 3:29 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Thu, Mar 22, 2012 at 11:22 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> Hi Arnd & Olof,
>>
>> Please help to merge this patch from arch-pxa git tree.
>>
>> The following changes since commit c16fa4f2ad19908a47c63d8fa436a1178438c7e7:
>>
>> ?Linux 3.3 (2012-03-18 16:15:34 -0700)
>>
>> are available in the git repository at:
>> ?git://github.com/hzhuang1/linux.git board-specific
>
> I didn't include this branch in the pull requests I sent out today --
> I couldn't tell from the pull request if it's a bug fix or support for
> a new feature. If it's a fix, we can include it with the bugfix
> branches we send through the -rc cycles. If not, we'll stage it for
> 3.5 once we start the new next/* branches. Please make it easy for us
> to decide by motivating one or the other with the pull request.
>
It's OK to queue this into 3.5.

> Also, did you see the discussions about recent PXA fallout due to
> various cleanups? You might want to double-check and make sure that
> the mainline sources work well on your platforms and send fixes as
> appropriate.
>
I noticed it. I'll verify it in the next week.

> Finally, a nit:
>
>> Paul Parsons (1):
>> ? ? ?pxa/hx4700: Add standard UART to hx4700_pin_config[]
>
> We tend to use:
>
> ARM: <platform>: <subject>
>
> for patch subjects. I don't reject patches due to a couple of slightly
> misformatted patch subjects, but please update to use something like
> "ARM: pxa: hx4700: <...>" in the future.
>
No problem. I'll change it.

Thanks
Haojian
