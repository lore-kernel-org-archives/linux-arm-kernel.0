From: trblinux@gmail.com (Tushar Behera)
Date: Tue, 08 Jul 2014 08:30:13 +0530
Subject: [PATCH 2/3] ARM: dts: Update the parent for Audss clocks in
 Exynos5420
In-Reply-To: <53BB2E7A.5080204@samsung.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>	<1402464739-19044-3-git-send-email-tushar.b@samsung.com>	<CAD=FV=W5yh58fYTwRZxmZt=BORcZMSRV0oRe12yA74Q5h2S4YQ@mail.gmail.com>	<7hpphwlgn0.fsf@paris.lan>	<CAC5m3Bzey-YoPLmjAq4YNPQ13rojtVFWAbnhX6-ZFtYZwEdMWg@mail.gmail.com>	<7h8uojk61a.fsf@paris.lan>	<53ACE724.7090606@gmail.com>	<CAGa+x86COQz+cYtrXWrP-sjFGz-gi2tf6GEvLiKYoQwg1zMivQ@mail.gmail.com>
 <CAGa+x87LHiYGb03=GRcZisK1=TyakW1htd1E2vOQ6ijZKw8syg@mail.gmail.com>
 <53B2A2A5.4070203@gmail.com> <53BB2E7A.5080204@samsung.com>
Message-ID: <53BB5EBD.5030607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2014 05:04 AM, Kukjin Kim wrote:
> On 07/01/14 20:59, Tushar Behera wrote:
>> On 06/27/2014 08:18 PM, Kevin Hilman wrote:
>>> On Fri, Jun 27, 2014 at 7:18 AM, Kevin Hilman<khilman@linaro.org> 
>>> wrote:
>>>> On Thu, Jun 26, 2014 at 8:38 PM, Tushar Behera<trblinux@gmail.com> 
>>>> wrote:
>>>>
>>>>> Would you please provide me the environment setting of your u-boot?
>>>>> U-boot environment on my board has been over-written, I would like to
>>>>> set it same as yours and try to reproduce the issue at my end. With
>>>>> only
>>>>> 'sound init', I don't seem to hit this issue anymore.
>>>>
>>>> Attached is a full boot log using v3.16-rc2 with my patch adding
>>>> CLK_IGNORE_UNUSED to mau_epll and Doug's aclk66_peric patch.  In the
>>>> boot log, you'll see the output of 'printenv' inside u-boot where the
>>>> environment is dumped.
>>>
>>> Oops, I sent you a boot log for the octa board.  Here's the one for
>>> peach-pi with the same kernel (built with upstream exynos_defconfig)
>>>
>>> Kevin
>>>
>>
>> The u-boot version is a little different on my Peach-Pi as compared to
>> the market release version. Not sure if that is making any difference.
>>
>> Peach # version
>>
>> U-Boot 2013.04 (Feb 13 2014 - 16:35:03) for Peach
>> armv7a-cros-linux-gnueabi-gcc.real (4.8.1_cos_gg_feea904_4.8.1-r66)
>> 4.8.x-google 20130905 (prerelease)
>> GNU ld (binutils-2.22_cos_gg_2) 2.22
>>
> 
> Note that I've applied this only from this series so I'm not sure how
> much the problem can be solved...any updates for 1/3 and 3/3?
> 
> - Kukjin

Thanks for applying 2/3. I am working on 1/3 to see if we are following
the right approach to fix Kevin's issue (unfortunately, I am not hitting
the bug on my board ATM). 3/3 has already been merged through a
different patchset.

-- 
Tushar Behera
