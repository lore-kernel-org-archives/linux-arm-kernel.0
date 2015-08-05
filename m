From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 05 Aug 2015 18:12:09 +0530
Subject: [PATCH-v5 2/5] i2c: pxa: enable/disable i2c module across msg xfer
In-Reply-To: <CAKfKVtGzDjgHzy70aa0d2W=ROMcxVzerg-qpuB9e4PaGKPpMTQ@mail.gmail.com>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>	<1437482466-16126-3-git-send-email-vaibhav.hiremath@linaro.org>
 <CAKfKVtGzDjgHzy70aa0d2W=ROMcxVzerg-qpuB9e4PaGKPpMTQ@mail.gmail.com>
Message-ID: <55C204A1.3060206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 05 August 2015 04:16 PM, Shubhrajyoti Datta wrote:
> hi ,
> On Tue, Jul 21, 2015 at 6:11 PM, Vaibhav Hiremath
> <vaibhav.hiremath@linaro.org> wrote:
>> From: Yi Zhang <yizhang@marvell.com>
>>
>> Enable i2c module/unit before transmission and disable when it
>> finishes.
>>
>> why?
>> It's because the i2c bus may be disturbed if the slave device,
>> typically a touch, powers on.
>
> Why should that be an issue?
> Is it an errata.
>

Not I am aware of.

> In which mode it is an issue slave / master or both?
>

since it talks about touch, I expect it to be master mode.

Thanks,
Vaibhav
