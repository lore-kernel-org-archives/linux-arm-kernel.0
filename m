From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 May 2012 08:38:47 +0100
Subject: [PATCH 02/16] ARM: ux500: Enable LED heartbeat functionality
 on Snowball
In-Reply-To: <CACRpkdYiwjXiiR_WC9BvWt=dtXfMHXwSVhcfk4W+yQ6_D+paHQ@mail.gmail.com>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdYiwjXiiR_WC9BvWt=dtXfMHXwSVhcfk4W+yQ6_D+paHQ@mail.gmail.com>
Message-ID: <4FBB4287.9050901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/12 22:33, Linus Walleij wrote:
> On Fri, May 18, 2012 at 10:39 AM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> This patch configures the user LED on Snowball to double flash
>> every second or so, whilst it's still alive. This can give key
>> indications as to what the board is doing in the case of no
>> console output.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>
> This doesn't look like it has anything to do with the DT stuff, shall
> I queue it in the ux500 tree?

Yes please.


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
