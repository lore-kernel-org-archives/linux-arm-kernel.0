From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 01 Mar 2012 12:34:44 +0100
Subject: [PATCH 1/5] mfd : ux500 - Cleanup duplicate definitions
In-Reply-To: <20120301113944.GJ9008@sortiz-mobl>
References: <1330465569-567-1-git-send-email-daniel.lezcano@linaro.org>
 <20120301113944.GJ9008@sortiz-mobl>
Message-ID: <4F4F5ED4.2070508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2012 12:39 PM, Samuel Ortiz wrote:
> Hi Daniel,
>
> On Tue, Feb 28, 2012 at 10:46:05PM +0100, daniel.lezcano at linaro.org wrote:
>> From: Daniel Lezcano<daniel.lezcano@linaro.org>
>>
>> I missed in my previous patch the A9_MASK_REQ[_MASK] were
>> already defined. Let's remove the duplicate definitions.
>>
>> The PRCMU_GIC_DELAY macro could be removed as it is not
>> really useful here.
> This one and the 4 other patches applied. Thanks.

Thanks Samuel.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
