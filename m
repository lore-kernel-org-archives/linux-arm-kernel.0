From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 09 May 2012 11:24:59 +0100
Subject: [PATCH 07/15] drivers/power: Carry out platform_data error
 checking on ab8500 devices
In-Reply-To: <CACRpkdYkqj6Zr=05Byk+tPc1ohjfDoZKCkTmu9zcZpgKxV8wpg@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdYkqj6Zr=05Byk+tPc1ohjfDoZKCkTmu9zcZpgKxV8wpg@mail.gmail.com>
Message-ID: <4FAA45FB.500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/12 09:51, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> In their current state the ab8500 power devices explode if platform data
>> isn't provided. This patch prevents this from happening and informs the
>> user of what has happened.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> This or equivalent is already submitted and merged by Anton into the
> power tree I think?

It is, and I sent him a derivative of this patch which he has also 
applied, hence his can now be ignored.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
