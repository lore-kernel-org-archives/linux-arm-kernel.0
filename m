From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 6 Sep 2017 12:19:21 +0100
Subject: [PATCH v6 0/7] Add RAS virtualization support for SEA/SEI
 notification type in KVM
In-Reply-To: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <CAFEAcA9=Ct6ucd8kPWyi3vSzahEQpOqLEakD36vxWmw=JcppFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2017 at 11:38, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> In the firmware-first RAS solution, corrupt data is detected in a
> memory location when guest OS application software executing at EL0
> or guest OS kernel El1 software are reading from the memory. The
> memory node records errors in an error record accessible using
> system registers.

Hi Dongjiu -- it looks like this patch set is extending
the API KVM provides to userspace, but it doesn't update
the documentation in Documentation/virtual/kvm/api.txt.
I appreciate the API is still somewhat under discussion,
but if you can include the docs updates it's helpful to
me for reviewing whether the API makes sense from the
userspace consumer end of it.

thanks
-- PMM
