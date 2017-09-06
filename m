From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 6 Sep 2017 19:29:25 +0800
Subject: [PATCH v6 0/7] Add RAS virtualization support for SEA/SEI
 notification type in KVM
In-Reply-To: <CAFEAcA9=Ct6ucd8kPWyi3vSzahEQpOqLEakD36vxWmw=JcppFQ@mail.gmail.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA9=Ct6ucd8kPWyi3vSzahEQpOqLEakD36vxWmw=JcppFQ@mail.gmail.com>
Message-ID: <0695fa5c-2b82-703b-32f7-dfbbbfbcb1b3@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 2017/9/6 19:19, Peter Maydell wrote:
> On 28 August 2017 at 11:38, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>> In the firmware-first RAS solution, corrupt data is detected in a
>> memory location when guest OS application software executing at EL0
>> or guest OS kernel El1 software are reading from the memory. The
>> memory node records errors in an error record accessible using
>> system registers.
> 
> Hi Dongjiu -- it looks like this patch set is extending
> the API KVM provides to userspace, but it doesn't update
> the documentation in Documentation/virtual/kvm/api.txt.
> I appreciate the API is still somewhat under discussion,
> but if you can include the docs updates it's helpful to
> me for reviewing whether the API makes sense from the
> userspace consumer end of it.

sure, it should. thanks a lot for the reminder. I will update the related docs
in my next patch set version.

> 
> thanks
> -- PMM
> 
> .
> 
