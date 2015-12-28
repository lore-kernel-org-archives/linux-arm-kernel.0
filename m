From: bjorn@kryo.se (Bjorn Andersson)
Date: Mon, 28 Dec 2015 10:41:37 -0800
Subject: [RESEND v4 0/6] remoteproc: Add driver for STMicroelectronics
 platforms
In-Reply-To: <CAK=WgbbWTdDGMYOFjVO3s1bt1r5iou6Q-hHOh4SZG=rQuEa2eQ@mail.gmail.com>
References: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
 <CAK=WgbZbiq_BAUEti9tWUtWqZPU_4gDJ5Mfqur=Ou2N4Ea+2GQ@mail.gmail.com>
 <20151126091043.GO12874@x1>
 <CAK=WgbbWTdDGMYOFjVO3s1bt1r5iou6Q-hHOh4SZG=rQuEa2eQ@mail.gmail.com>
Message-ID: <CAJAp7OgZwf-Cd+Drypqo92YNJBYtB-XCbW-noy-4BB5JZojRnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 1:32 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Thu, Nov 26, 2015 at 11:10 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> On Thu, 26 Nov 2015, Ohad Ben-Cohen wrote:
>>> On Tue, Nov 24, 2015 at 3:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>> > ST's platforms often have multiple co-processors (usually ST40s or ST231s)
>>> > on-board.  This provides the Linux-side infrastructure to flash and boot
>>> > them successfully.
>>> >
>>> > This set has been tested on an STiH410-B2120.
>>>
>>> It would be nice if you could get at least one Reviewed-by tag coming
>>> outside of ST (e.g., Suman or Bjorn who are actively using and
>>> improving remoteproc).
>>
>> If you require reviews by these guys, shouldn't they be Maintainers?
>
> Additional review isn't a requirement, but it's a plus.
>
>> Please be aware that
>> the DTS(I) changes are applied to this set for your information only
>> and are not to be applied through the RemoteProc tree.  The usual
>> process to which we conform is that Maxime (the STi Maintainer) will
>> apply the DT changes *after* the main driver has been applied, in this
>> case by you.
>
> Ok, great, so I will not take patches 5 and 6.
>

I interpreted this as you picked patch 1-4 and didn't pay more
attention to them, but I can't find them in your kernel.org trees. So
I've looked through them again.

Please apply patch 1, 3 and 4 to your tree Ohad. I was unable to find
a v5 of patch 2, but it's unrelated so no need to wait for a new
version of that.

Regards,
Bjorn
