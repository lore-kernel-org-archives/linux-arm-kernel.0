From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 May 2012 08:41:31 +0100
Subject: [PATCH 06/16] ARM: ux500: Apply db8500-prcmu regulator information
 to db8500 Device Tree
In-Reply-To: <CACRpkdYBmLZUzMUDx1qd7r5kZx42MHOPaveV-vb4B38C+XpggA@mail.gmail.com>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYBmLZUzMUDx1qd7r5kZx42MHOPaveV-vb4B38C+XpggA@mail.gmail.com>
Message-ID: <4FBB432B.50009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/12 22:37, Linus Walleij wrote:
> On Fri, May 18, 2012 at 10:39 AM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Here we inform Device Tree of which regulators are provided by the db8500-
>> prcmu. This way we can reference some of their consumers directly from the
>> Device Tree e.g. SMSC911x Ethernet chip and the Nomadik I2C controller.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> I am hesitant about the I2C controller. That thing is a voltage domain and
> it appears these should be handled centrally. using runtime PM and
> power domains.

This patch doesn't have anything to do with the I2C controller. I only 
mentioned it as an example. Would you like me to change the commit log 
and re-submit?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
