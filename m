From: rob.jones@codethink.co.uk (Rob Jones)
Date: Fri, 11 Jul 2014 11:03:05 +0100
Subject: [PATCH 1/5] gpiolib: devres: Introduce the function
 devm_request_gpio_array
In-Reply-To: <CABxcv=mhMMQxqVRM28NucnSW62v_3ghnT58JqFxvK=2bjxizdw@mail.gmail.com>
References: <cover.1404665589.git.himangi774@gmail.com>	<1a1752ce7455bac8f2505a9790da891a830699f5.1404665589.git.himangi774@gmail.com>	<53BD2509.6070803@codethink.co.uk>	<CACRpkdZWfYN14aki-UqvWp1K0exVj-mMK92q431QueSVvjZFuA@mail.gmail.com>	<53BE7288.6060503@codethink.co.uk>
 <CABxcv=mhMMQxqVRM28NucnSW62v_3ghnT58JqFxvK=2bjxizdw@mail.gmail.com>
Message-ID: <53BFB659.8050306@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/07/14 01:35, Javier Martinez Canillas wrote:
> Hello Rob,
>
> On Thu, Jul 10, 2014 at 1:01 PM, Rob Jones <rob.jones@codethink.co.uk> wrote:

<snip>

>>
>> I will certainly consider it. I'm in the middle of something else right
>> now but I should be available in a day or two and I'll have a look.
>>
>>
>
> I'm working on a driver for a PMIC which uses a set of GPIO to select
> a particular register. Right now I'm getting each GPIO independently
> but Linus mentioned [0] the devm_gpio_request_array() patch you
> posted.
>
> Now, I'm not using the integer-based GPIO API but the new
> descriptor-based one so I was wondering if you are already
> implementing a devm_gpiod_get_array() or if you want me to implement
> it myself.
>

As I said, I'm deep in something else for the next day or two so if you
need it urgently you should probably do it yourself but if you don't
mind waiting until next week, I can have a go.

Your call, let me know.

> Best regards,
> Javier
>
> [0]: https://lkml.org/lkml/2014/7/10/166
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Rob Jones
Codethink Ltd
mailto:rob.jones at codethink.co.uk
tel:+44 161 236 5575
