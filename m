From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 04 May 2012 15:00:32 +0100
Subject: [PATCH 12/15] mfd/db8500-prcmu: Register as a platform driver
 instead of only probing
In-Reply-To: <CACRpkdZB5Hgdb1bGr3uxKYbJgQhatxMR2Pwf7f0NQa7c34gC-Q@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdZB5Hgdb1bGr3uxKYbJgQhatxMR2Pwf7f0NQa7c34gC-Q@mail.gmail.com>
Message-ID: <4FA3E100.7030309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/12 09:07, Linus Walleij wrote:
> On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Pass the probe function as part of the platform_driver struct and
>> register using the more common platform_driver_register call. In
>> subsequent patches we'll also add DT support into the struct.
>>
>> CC: Samuel Ortiz<sameo@linux.intel.com>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>
> Alternatively, if you get Sam's ACK I can carry this in the ux500 tree.

Sam, anything on this?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
