From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 26 Nov 2015 11:32:38 +0200
Subject: [RESEND v4 0/6] remoteproc: Add driver for STMicroelectronics
 platforms
In-Reply-To: <20151126091043.GO12874@x1>
References: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
 <CAK=WgbZbiq_BAUEti9tWUtWqZPU_4gDJ5Mfqur=Ou2N4Ea+2GQ@mail.gmail.com>
 <20151126091043.GO12874@x1>
Message-ID: <CAK=WgbbWTdDGMYOFjVO3s1bt1r5iou6Q-hHOh4SZG=rQuEa2eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 11:10 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 26 Nov 2015, Ohad Ben-Cohen wrote:
>> On Tue, Nov 24, 2015 at 3:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> > ST's platforms often have multiple co-processors (usually ST40s or ST231s)
>> > on-board.  This provides the Linux-side infrastructure to flash and boot
>> > them successfully.
>> >
>> > This set has been tested on an STiH410-B2120.
>>
>> It would be nice if you could get at least one Reviewed-by tag coming
>> outside of ST (e.g., Suman or Bjorn who are actively using and
>> improving remoteproc).
>
> If you require reviews by these guys, shouldn't they be Maintainers?

Additional review isn't a requirement, but it's a plus.

> Please be aware that
> the DTS(I) changes are applied to this set for your information only
> and are not to be applied through the RemoteProc tree.  The usual
> process to which we conform is that Maxime (the STi Maintainer) will
> apply the DT changes *after* the main driver has been applied, in this
> case by you.

Ok, great, so I will not take patches 5 and 6.

Thanks,
Ohad.
