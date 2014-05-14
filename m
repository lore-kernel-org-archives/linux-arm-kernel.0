From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 14 May 2014 22:20:14 +0200
Subject: [GIT PULL 1/4] Samsung clock Exynos5260 support for v3.16
In-Reply-To: <20140514201313.19795.35617@quantum>
References: <1400090591-5064-1-git-send-email-t.figa@samsung.com>
 <5373CB1A.1040801@samsung.com> <20140514201313.19795.35617@quantum>
Message-ID: <5373CFFE.1000209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 14.05.2014 22:13, Mike Turquette wrote:
> Quoting Kukjin Kim (2014-05-14 12:59:22)
>> On 05/15/14 03:03, Tomasz Figa wrote:
>>
>> Hi Mike,
>>
>> I've talked to Tomasz about current samsung related clock stuff. Since 
>> they are mostly having dependency on samsung tree now not clock core 
>> stuff, so would be better if it could be sent to upstream via samsung 
>> tree. And as you know, updating arch/arm/ and clock stuff are usually 
>> required for adding new SoC or supporting CCF newly...
> 
> The Samsung clk pull requests only touch two arch/arm Kconfig files and
> one dtsi file. That's not a lot of arch/arm churn. Is there a strong
> reason that this needs to go through the samsung/arm-soc trees?
> Otherwise it should continue to go through the clk tree.

Obviously they are patches for Samsung clock drivers. ;)

The issue here is that there is a number of patches already merged in
Samsung tree on which the patches discussed here depend.

> 
>>
>> How do you think? Basically I need your agreement for it.
> 
> Based on the above pull requests I do not see the need for changing how
> code gets merged.

As long as there are no dependencies on arch code and series being
applied do not touch arch code, this is perfectly fine. Unfortunately
this is rarely the case, at least for Samsung platforms and at least for
now. After we finish with arch clean-up and move all code to appropriate
subsystems, it should become easier, though.

Best regards,
Tomasz
