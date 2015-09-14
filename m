From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 14 Sep 2015 10:37:08 +0530
Subject: [PATCH-v5 RESEND 2/5] i2c: pxa: enable/disable i2c module across
 msg xfer
In-Reply-To: <20150911185312.GA1516@katana>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150911185312.GA1516@katana>
Message-ID: <55F655FC.8070308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 12 September 2015 12:23 AM, Wolfram Sang wrote:
> On Mon, Aug 24, 2015 at 11:29:35AM +0530, Vaibhav Hiremath wrote:
>> From: Yi Zhang <yizhang@marvell.com>
>>
>> Enable i2c module/unit before transmission and disable when it
>> finishes.
>>
>> why?
>> It's because the i2c bus may be disturbed if the slave device,
>> typically a touch, powers on.
>
> I am not convinced, "may disturb" is too weak for me. It would need a
> way more detailed description of the problem which makes clear that
> this mechanism is the only way to go forward.
>

Hmm, Ok.
Not sure what else I can bring up here.

> Can't you use Runtime PM for that?
>

I haven't tried it though, I can give a try and check.

Thanks,
Vaibhav
