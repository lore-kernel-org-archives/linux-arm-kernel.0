From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 May 2012 08:39:25 +0100
Subject: [PATCH 04/16] ARM: ux500: Only initialise STE's UIBs on boards
 which support them
In-Reply-To: <CACRpkdatpXKzzVpHLFrF+26RJoRYzrS3tZb2gg_aUdM_tzzg4A@mail.gmail.com>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdatpXKzzVpHLFrF+26RJoRYzrS3tZb2gg_aUdM_tzzg4A@mail.gmail.com>
Message-ID: <4FBB42AD.7050907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/12 22:36, Linus Walleij wrote:
> On Fri, May 18, 2012 at 10:39 AM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> ST-Ericsson uses User Interface Boards to extend functionality of
>> some of their development boards. However, these aren't compatible
>> with all the supported boards found in Mainline (Snowball for
>> instance). This patch ensures that the UIBs are only probed on
>> boards which can actually support them. This in turn saves lots of
>> unnecessary error messages normally found in Snowball's boot log.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>
> Shall I take this through the ux500  tree?

Yes please.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
